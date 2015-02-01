require 'active_support'
require 'active_record'
require 'blame/userstamp'

if defined?(Rails::Railtie)
  class Railtie < Rails::Railtie
    initializer 'blame.insert_into_active_record' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send :include, Blame::Userstamp
        ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Blame::UserstampMigrationHelper
      end
    end
  end
else
  if defined?(ActiveRecord)
    ActiveRecord::Base.send :include, Blame::Userstamp
    ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Blame::UserstampMigrationHelper
  end
end
