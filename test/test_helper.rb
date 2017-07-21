require 'bundler/setup'
Bundler.setup(:default, :test)

require 'test/unit'

# Initialize the plugin
require File.dirname(__FILE__) + '/../lib/blamer'

# Use in-memory sqlite3
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

# Create test tables
require File.dirname(__FILE__) + '/schema'

# Load test models
require File.dirname(__FILE__) + '/models/user'
require File.dirname(__FILE__) + '/models/monkey'
require File.dirname(__FILE__) + '/models/widget'
require File.dirname(__FILE__) + '/models/sprocket'
