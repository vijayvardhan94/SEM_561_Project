require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
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
    
  
  
  
  test "index should have login and about links" do
    get "/"
    assert_response :success    
    assert_select "a[href='/pages/about']", 1
  end
end
