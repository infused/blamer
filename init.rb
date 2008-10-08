$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'blame'
ActiveRecord::Base.send :include, Blame::Userstamp
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Blame::UserstampMigrationHelper