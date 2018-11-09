require File.dirname(__FILE__) + '/test_helper.rb'

class DefaultUserstampBlameTest < Test::Unit::TestCase

  # Override the default userstamp_object method
  class Sprocket < ActiveRecord::Base
    def userstamp_object
      Monkey.banana
    end

    def default_userstamp_object
      @default_userstamp_object ||= Monkey.create!
    end
  end

  def test_create
    Monkey.banana = nil
    @sprocket = Sprocket.create! :name => 'One'
    assert_equal 'One', @sprocket.name
    assert_equal @sprocket.default_userstamp_object.id, @sprocket.created_by
    assert_equal @sprocket.default_userstamp_object.id, @sprocket.updated_by
  end

  def test_update
    @monkey = Monkey.create!
    Monkey.banana = @monkey
    @sprocket = Sprocket.create! :name => 'Two'
    Monkey.banana = nil
    @sprocket.update_attribute(:name, 'Three')

    @sprocket.reload
    assert_equal 'Three', @sprocket.name
    assert_equal @monkey.id, @sprocket.created_by
    assert_equal @sprocket.default_userstamp_object.id, @sprocket.updated_by
  end

end
