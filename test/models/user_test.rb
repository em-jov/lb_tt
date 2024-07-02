require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:first)
  end
  
  test 'should be valid with valid attributes' do
    assert @user.valid?
  end

  test "should be invalid if username is not present" do
    @user.username = ""
    refute @user.valid?
  end

  test "should be invalid if username is not unique" do
    user = User.new(username: @user.username, password: 'xyz')
    refute user.valid?
  end

  test 'should be invalid if password is not present' do
    @user.password = nil
    refute @user.valid?
  end
end
