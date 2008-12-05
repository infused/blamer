require 'test/unit'
require 'rubygems'
require 'active_record'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

# Initialize the plugin
require File.dirname(__FILE__) + '/../init'

# Create test tables
require File.dirname(__FILE__) + '/schema'

# Load test models
require File.dirname(__FILE__) + '/models/user'
require File.dirname(__FILE__) + '/models/monkey'
require File.dirname(__FILE__) + '/models/widget'
require File.dirname(__FILE__) + '/models/sprocket'
