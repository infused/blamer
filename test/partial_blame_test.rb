require File.dirname(__FILE__) + '/test_helper.rb'

class PartialBlameTest < Test::Unit::TestCase
  def setup
    @user1 = User.create!
    @user2 = User.create!
    Thread.current[:current_user] = @user1
    @widget = Widget.create! :name => 'One'
  end

  def test_create
    assert_equal 'One', @widget.name
    assert_equal @user1.id, @widget.created_by
    assert_equal @user1.id, @widget.updated_by
  end

  def test_update
    Thread.current[:current_user] = @user2
    @widget.update_attribute(:name, 'Two')

    @widget.reload
    assert_equal 'Two', @widget.name
    assert_equal @user1.id, @widget.created_by
    assert_equal @user2.id, @widget.updated_by
  end

end
