require File.dirname(__FILE__) + '/test_helper.rb'

class OverrideBlameTest < Test::Unit::TestCase
  
  # Override the default userstamp_object method
  class Sprocket < ActiveRecord::Base
    def userstamp_object
      Monkey.banana
    end
  end
  
  def setup
    @monkey1 = Monkey.create
    @monkey2 = Monkey.create
    Monkey.banana = @monkey1
    @sprocket = Sprocket.create :name => 'One'
  end
  
  def test_create
    assert_equal @monkey1.id, @sprocket.created_by
    assert_equal @monkey1.id, @sprocket.updated_by
  end
  
  def test_update
    Monkey.banana = @monkey2
    @sprocket.update_attribute(:name, 'Two')
    assert_equal @monkey1.id, @sprocket.created_by
    assert_equal @monkey2.id, @sprocket.updated_by
  end
  
end