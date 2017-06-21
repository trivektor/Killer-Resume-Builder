require 'test_helper'

class ResumeEducationsControllerTest < ActionController::TestCase
  
  def setup
    activate_authlogic
    @user = Factory(:user)
  end
  
  # test "should redirect if not logged in" do
  #     resume = Factory(:resume)
  #     get :new, :resume_id => resume.id
  #     
  #     assert_response 302
  #   end
  
  test "should get new if logged in" do
    
    user_session = UserSession.create(@user)
    
    resume = Factory(:resume)
    resume.user_id = @user.id
    resume.save
    
    get :new, :resume_id => resume.id
    
    assert_response 200
  end
  
end
