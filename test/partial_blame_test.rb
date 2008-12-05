require File.dirname(__FILE__) + '/test_helper.rb'

class PartialBlameTest < Test::Unit::TestCase
  def setup
    ActiveRecord::Base.partial_updates = true
    @user1 = User.create
    @user2 = User.create
    User.current_user = @user1
    @widget = Widget.create :name => 'One'
  end
  
  def test_partial_updates_enabled
    assert ActiveRecord::Base.partial_updates
  end
  
  def test_create
    assert_equal @user1.id, @widget.created_by
    assert_equal @user1.id, @widget.updated_by
  end
  
  def test_update
    User.current_user = @user2
    @widget.update_attribute(:name, 'Two')
    assert_equal @user1.id, @widget.created_by
    assert_equal @user2.id, @widget.updated_by
  end
  
end