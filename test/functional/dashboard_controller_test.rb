require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  
  setup :activate_authlogic
  
  test "should redirect if not logged in" do
    get :index
    assert_response 302
    assert_redirected_to login_url
    assert_equal "You must be logged in to access this page", flash[:notice]
    
  end
  
  test "should get index if logged in" do
    
    user = Factory(:user)
    
    assert user
    
    user_session = UserSession.create(user)
    
    get :index
    assert_response 200
  end
  
end
