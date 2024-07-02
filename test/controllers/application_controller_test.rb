require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:first)
  end

  test "should return current user when session user_id is set" do
    post sessions_path, params: { username: @user.username, password: 'test' }    
    assert_equal @user, @controller.current_user
  end

  test "should return nil when session user_id is not set" do
    get root_path
    assert_nil @controller.current_user
  end

  test "should return nil when session user_id is invalid" do
    post sessions_path, params: { username: @user.username, password: 'test' }
    session[:user_id] = -1
    assert_nil @controller.view_context.current_user
  end

end
