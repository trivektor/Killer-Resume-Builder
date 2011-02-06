require 'test_helper'

class ResumeTest < ActiveSupport::TestCase
  
  test "save resume with no title and no url" do
    resume = Resume.new
    assert !resume.save
  end
  
  test "save resume with a title and a url" do
    resume = Resume.new(:url => "trivektor", :title => "Tri Vuong's resume", :user_id => 1)
    resume.save
    assert_equal resume.url, "trivektor"
    assert_equal resume.title, "Tri Vuong's resume"
    assert_equal resume.user_id, 1
  end
  
  test "when a resume is created, its associations should also be created" do
    resume = Resume.new(:url => "trivektor", :title => "Tri Vuong's resume", :user_id => 1)
    resume.save
    
    resume_education = ResumeEducation.find_by_resume_id(resume.id)
    resume_field_work = ResumeFieldWork.find_by_resume_id(resume.id)
    resume_skill = ResumeSkill.find_by_resume_id(resume.id)
    
    assert_equal resume_education.resume_id, resume.id
    assert_equal resume_field_work.resume_id, resume.id
    assert_equal resume_skill.resume_id, resume.id
  end
  
  test "when a resume is deleted, its associated educations should also be deleted" do
    resume = Resume.new(:url => "trivektor", :title => "Tri Vuong's resume", :user_id => 1)
    resume.save
    resume_education = ResumeEducation.new(:institution => "University of Toronto", :begin_date => "Sep 2004", :end_date => "Dec 2008")
    resume_education.resume_id = resume.id
    resume_education.save
    Resume.delete(resume.id)
    assert_equal nil, ResumeEducation.find_by_resume_id(resume.id)
  end
  
  
  
end
