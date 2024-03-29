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
    get "/users"
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
    #redis_Server
   # @redis = redis
    get "/pages/dashboard"
       
    assert_select "div[data-id='fitbit'][data-viewtype='0']", 1
    assert_select "div[data-id='fitbit'][data-viewtype='1']", 1
    assert_select "div[data-id='fitbit'][data-viewtype='2']", 1
    assert_select "div[data-id='fitbit'][data-viewtype='3']", 1
    assert_select "div[data-id='fitbit'][data-viewtype='4']", 1
    assert_select "div[data-id='welcome']", 1
  end

  test "user change password" do
    # get the login page
    get "/pages/login"
    assert_equal 302, status
    # post the login and follow through to the home page
    post "/users/sign_in", params: {user: { email: users(:prateek).email,password: 'prateek1234'} }
    follow_redirect!
    assert_equal 200, status
    assert_equal "/pages/login", path    
    assert_equal 'Signed in successfully.', flash[:notice]
    get "/users/edit"
    assert_response :success
    assert_select "input[id='user_email'][type='email']", 1
    assert_select "input[id='user_password'][type='password']", 1
    assert_select "input[id='user_password_confirmation'][type='password']", 1
    assert_select "input[id='user_current_password'][type='password']", 1
  end

  test "user sign out" do
    get "/pages/login"
    assert_equal 302, status
    # post the login and follow through to the home page
    post "/users/sign_in", params: {user: { email: users(:prateek).email,password: 'prateek1234'} }
    follow_redirect!
    assert_equal 200, status
    assert_equal "/pages/login", path    
    assert_equal 'Signed in successfully.', flash[:notice]
    delete "/users/sign_out"
    assert_response :redirect
    assert_equal '/users/sign_out' ,path
  end

  test "check database connectivity" do
    require './config/environment.rb' # Assuming the script is located in the root of the rails app
    begin
      ActiveRecord::Base.establish_connection # Establishes connection
      ActiveRecord::Base.connection # Calls connection object
      puts "CONNECTED!" if ActiveRecord::Base.connected? 
      puts "NOT CONNECTED!" unless ActiveRecord::Base.connected?
      rescue
      puts "NOT CONNECTED!"
    end
  end


  test "check database insert" do
    user_test = User.find_by(email:users(:prateek).email)
    assert_equal user_test.fitbitconfigured,true
    user_test.fitbitkey = '1234'        
    user_test.save   
    assert_equal user_test.email,users(:prateek).email
    user_test_new =  User.find_by(email:users(:prateek).email)
    assert_equal user_test_new.fitbitkey,'1234'
  end

end
