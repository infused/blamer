require File.dirname(__FILE__) + '/test_helper.rb'

class Monkey
  cattr_accessor :banana
  attr_accessor :id
  
  def initialize(options)
    @id = options[:id]
  end
end

class OverrideBlameTest < Test::Unit::TestCase
  
  # override the default userstamp_object method
  class Sprocket < ActiveRecord::Base
    def userstamp_object
      Monkey.banana
    end
  end
  
  def setup
    Monkey.banana = Monkey.new :id => 5501
  end
  
  def test_create
    sprocket = Sprocket.create :name => 'One'
    assert_equal 5501, sprocket.created_by
    assert_equal 5501, sprocket.updated_by
  end
  
  def test_update
    Monkey.banana = Monkey.new :id => 5502
    sprocket = Sprocket.find(1)
    sprocket.update_attribute(:name, 'Two')
    assert_equal 5501, sprocket.created_by
    assert_equal 5502, sprocket.updated_by
  end
  
end