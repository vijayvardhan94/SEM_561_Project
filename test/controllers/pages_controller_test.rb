require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get pages_about_url
    assert_response :success
  end

  test "should get login" do
    get pages_login_url
    assert_response :success
  end

  test "should get index" do
    get pages_index_url
    assert_response :success
  end
  
  test "should get dashboard" do
    get '/pages/dashboard'
    assert_response :success
  end
  
  test "index should have signup fields" do
    get '/'
    assert_response :success
    assert_select "form input[type=text][name=firstName]", 1
    assert_select "form input[type=text][name=lastName]", 1
    assert_select "form input[type=email][name=email]", 1
    assert_select "form input[type=password][name=password]", 1
    assert_select "form input[type=password][name=confirm_password]", 1
  end

  test "index should have login and about links" do
    get '/'
    assert_response :success
    assert_select "a[href=<%=ENV[FITBIT_URL]%>]", 1
    assert_select "a[href='/pages/about']", 1
  end
end
