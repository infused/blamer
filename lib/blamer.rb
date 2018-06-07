require 'active_support'
require 'active_record'
require 'blamer/userstamp'

if defined?(Rails::Railtie)
  class Railtie < Rails::Railtie
    initializer 'blame.insert_into_active_record' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send :include, Blamer::Userstamp
        ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Blamer::UserstampMigrationHelper
      end
    end
  end
elsif defined?(ActiveRecord)
  ActiveRecord::Base.send :include, Blamer::Userstamp
  ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Blamer::UserstampMigrationHelper
end
