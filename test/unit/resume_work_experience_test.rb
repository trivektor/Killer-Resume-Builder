require 'test_helper'

class ResumeWorkExperienceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "should not create work experience without organization name, begin date and end date" do
    
    resume = Resume.create(:url => "trivektor", :title => "Tri Vuong's resume")
    
    resume_work_experience = ResumeWorkExperience.new(:organization_name => "", 
    :begin_date => "", :end_date => "", :resume_id => resume.id)
    
    assert !resume_work_experience.save
    
  end
  
  test "should create work experience with organization name, begin date and end date" do
    
    resume = Resume.create(:url => "trivektor", :title => "Tri Vuong's resume")
    
    resume_work_experience = ResumeWorkExperience.new(:organization_name => "", 
    :begin_date => "", :end_date => "", :resume_id => resume.id)
    
    resume_work_experience.save
    
    
    
  end
  
end
