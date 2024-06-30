require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = users(:second)
    assert user.valid?
  end

  test 'invalid without username' do
    user = User.new(username: nil, password: 'test')
    refute user.valid?
  end

  test 'invalid without password' do
    user = User.new(username: 'third_user', password: nil)
    refute user.valid?
  end

  test 'invalid without uniqe username' do
    user = User.new(username: 'first_user', password: 'test')
    refute user.valid?
  end
end
