require File.dirname(__FILE__) + '/test_helper.rb'

class User
  cattr_accessor :current_user
  attr_accessor :id
  
  def initialize(options)
    @id = options[:id]
  end
end

class BlameTest < Test::Unit::TestCase
  def setup
    User.current_user = User.new(:id => 9901)
  end
  
  def test_create
    widget = Widget.create :name => 'One'
    assert_equal 9901, widget.created_by
    assert_equal 9901, widget.updated_by
  end
  
  def test_update
    User.current_user = User.new(:id => 9902)
    widget = Widget.find(1)
    widget.update_attribute(:name, 'Two')
    assert_equal 9901, widget.created_by
    assert_equal 9902, widget.updated_by
  end
  

end
