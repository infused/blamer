require 'test/unit'
require 'rubygems'
require 'active_record'
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

require File.dirname(__FILE__) + '/../init.rb'

# Stop AR from printing schema statements
$stdout = StringIO.new

ActiveRecord::Base.logger
ActiveRecord::Schema.define(:version => 1) do
  create_table :widgets do |t|
    t.string :name
    t.userstamps
  end
  create_table :sprockets do |t|
    t.string :name
    t.userstamps
  end
end

class Widget < ActiveRecord::Base; end
class Sprocket < ActiveRecord::Base; end