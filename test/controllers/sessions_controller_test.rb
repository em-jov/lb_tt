require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:first)
  end
  
  test "should get login page" do
    get new_session_path
    assert_response :success
  end

  test "should create session for valid user" do
    post sessions_path, params: { username: @user.username, password: 'test' }
    assert_redirected_to root_path
    assert_equal 'You have logged in.', flash[:notice]
    assert_equal @user.id, session[:user_id]
  end

  test "should not create session for invalid password" do
    post sessions_path, params: { username: @user.username, password: 'invalid' }
    assert_response :unprocessable_entity
    assert_equal 'Invalid email or password', flash[:alert]
  end

  test "should increment login_failure_count for invalid password" do
    @user.update(login_failure_count: 0)
    post sessions_path, params: { username: @user.username, password: 'invalid' }
    assert_equal 1, @user.reload.login_failure_count
  end

  test "should redirect if login_failure_count is 3" do
    @user.update(login_failure_count: 3)
    post sessions_path, params: { username: @user.username, password: 'any' }
    assert_redirected_to root_path
    assert_equal 'Too many failed login attempts.', flash[:alert]
  end

  test "should reset login_failure_count on successful login" do
    @user.update(login_failure_count: 2)
    post sessions_path, params: { username: @user.username, password: 'test' }
    assert_equal 0, @user.reload.login_failure_count
  end

  test "should destroy session" do
    delete session_path(@user)
    assert_redirected_to root_path
    assert_equal 'You have been logged out.', flash[:notice]
    assert_nil session[:user_id]
  end
end
