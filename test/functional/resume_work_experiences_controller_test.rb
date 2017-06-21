require 'test_helper'

class ResumeWorkExperiencesControllerTest < ActionController::TestCase
  
  def setup
    
  end
  
  def teardown
    
  end
  
  test "should get new" do
    get :new, :resume_id => 1
    assert_response :success
  end
  
  test "should create resume work experience" do
    assert_difference('ResumeWorkExperience.count') do
      post :create, :resume_id => 1, :resume_work_experience => {:organization_name => "Organization 1", :begin_date => "May 30",
        :end_date => "May 31", :title => "Job title 1"}
    end  
  end
  
  test "should edit resume work experience" do
    get :show, :id => 
  end
  
end
