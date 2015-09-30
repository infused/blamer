require File.dirname(__FILE__) + '/test_helper.rb'

class BlameTest < Test::Unit::TestCase
  def setup
    @user1 = User.create!
    @user2 = User.create!
    User.current_user = @user1
    @widget = Widget.create! :name => 'One'
  end

  def test_create
    assert_equal 'One', @widget.name
    assert_equal @user1.id, @widget.created_by
    assert_equal @user1.id, @widget.updated_by
  end

  def test_update
    User.current_user = @user2
    @widget.update_attribute(:name, 'Two')

    @widget.reload

    assert_equal 'Two', @widget.name
    assert_equal @user1.id, @widget.created_by
    assert_equal @user2.id, @widget.updated_by
  end

  def test_console_create
    User.current_user = nil
    another_widget = Widget.create! :name => "Ten"

    assert_equal 'Ten', another_widget.name
    assert_equal nil, another_widget.created_by
    assert_equal nil, another_widget.updated_by
  end

  def test_console_update
    User.current_user = nil
    @widget.update_attribute(:name, 'Three')

    @widget.reload

    assert_equal 'Three', @widget.name
    assert_equal @user1.id, @widget.created_by
    assert_equal nil, @widget.updated_by
  end

end
