require 'active_record'

module Blamer
  module Userstamp
    def self.included(base)
      base.alias_method_chain :create, :userstamps
      base.alias_method_chain :update, :userstamps

      if base.respond_to?(:class_attribute)
        base.class_attribute :record_userstamps
        base.class_attribute :created_userstamp_column
        base.class_attribute :updated_userstamp_column
      else
        base.class_inheritable_accessor :record_userstamps, :instance_writer => false
        base.class_inheritable_accessor :created_userstamp_column, :instance_writer => false
        base.class_inheritable_accessor :updated_userstamp_column, :instance_writer => false
      end

      base.record_userstamps = true
      base.created_userstamp_column = :created_by
      base.updated_userstamp_column = :updated_by
    end

    private

    def userstamp_object
      User.current_user
    end

    def create_with_userstamps
      if record_userstamps && userstamp_object
        write_attribute(created_userstamp_column, userstamp_object.id) if respond_to?(created_userstamp_column)
        write_attribute(updated_userstamp_column, userstamp_object.id) if respond_to?(updated_userstamp_column)
      end
      create_without_userstamps
    end

    def update_with_userstamps(*args)
      if record_userstamps && userstamp_object && (!partial_updates? || changed?)
        write_attribute(updated_userstamp_column, userstamp_object.id) if respond_to?(updated_userstamp_column)
      end
      update_without_userstamps
    end

  end

  module UserstampMigrationHelper
    def userstamps
      column ActiveRecord::Base.created_userstamp_column, :integer
      column ActiveRecord::Base.updated_userstamp_column, :integer
    end
  end

end

ActiveRecord::Base.send :include, Blamer::Userstamp
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Blamer::UserstampMigrationHelper
