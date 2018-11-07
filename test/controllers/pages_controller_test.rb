require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:prateek)
  end

  test "should get about" do
    get "/pages/about"
    assert_response :success
  end

  test "should get login" do
    get "/users/sign_in"
    assert_response :success
  end

  test "should get index" do
    get "/"
    assert_response :success
  end
  
  test "only_access_authenticate_user" do    
      get "/pages/dashboard"
      assert_response :redirect
  end
    
  test " access profile page" do
    #get "/pages/profile"
    #assert_equal 302,status
    #assert_equal "/unauthenticated", path
    post "/users/sign_in", params: {user: { email: users(:prateek).email,password: 'prateek1234'} }
    follow_redirect!
    assert_equal 200, status
    assert_equal "/users", path    
    assert_equal 'Signed in successfully.', flash[:notice]
    get "/pages/profile"
    assert_equal 200,status

  end
  
  
  test "index should have login and about links" do
    get "/"
    assert_response :success    
    assert_select "a[href='/pages/about']", 1
  end

  test "user login " do
    # get the login page
    get "/pages/login"
    assert_equal 302, status
    # post the login and follow through to the home page
    post "/users/sign_in", params: {user: { email: users(:prateek).email,password: 'prateek1234'} }
    follow_redirect!
    assert_equal 200, status
    assert_equal "/pages/login", path    
    assert_equal 'Signed in successfully.', flash[:notice]
  end

  test "user login dashboard" do
    # get the login page
    get "/pages/login"
    assert_equal 302, status
    # post the login and follow through to the home page
    post "/users/sign_in", params: {user: { email: users(:prateek).email,password: 'prateek1234'} }
    follow_redirect!
    assert_equal 200, status
    assert_equal "/pages/login", path    
    assert_equal 'Signed in successfully.', flash[:notice]
    get "/pages/dashboard"
    assert_response :success    
    assert_select "div[data-id='fitbit'][data-viewtype='0']", 1
    assert_select "div[data-id='fitbit'][data-viewtype='1']", 1
    assert_select "div[data-id='fitbit'][data-viewtype='2']", 1
    assert_select "div[data-id='fitbit'][data-viewtype='3']", 1
    assert_select "div[data-id='fitbit'][data-viewtype='4']", 1
    assert_select "div[data-id='welcome']", 1
 
    end

end
