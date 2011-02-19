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
  
  test "when a resume is deleted, its associated educations should also be deleted" do
    resume = Resume.create(:url => "trivektor", :title => "Tri Vuong's resume", :user_id => 1)
    
    resume_id = resume.id

    ResumeEducation.create(:resume_id => resume_id, :institution => "University of Toronto", :begin_date => "Sep 2004", :end_date => "Dec 2008", :degree => "Degree")
    
    resume.destroy
    
    assert_equal nil, ResumeEducation.find_by_resume_id(resume_id)
  end
  
  test "when a resume is deleted, its associated skills should also be deleted" do
    resume = Resume.create(:url => "trivektor", :title => "Tri Vuong's resume", :user_id => 1)
    
    resume_id = resume.id
    
    ResumeSkill.create(:resume_id => resume_id, :skills => "Skill")
    
    resume.destroy
    
    assert_equal nil, ResumeSkill.find_by_resume_id(resume_id)
  end
  
  test "when a resume is deleted, its associated section order should also be deleted" do
    resume = Resume.create(:url => "trivektor", :title => "Tri Vuong's resume", :user_id => 1)
    
    resume_id = resume.id
  
    ResumeSectionOrder.create(:resume_id => resume_id, :orders => "orders")

    resume.destroy
    
    assert_equal nil, ResumeSectionOrder.find_by_resume_id(resume_id)
  end
  
  test "when a resume is deleted, its association personal information should also be deleted" do
    resume = Resume.create(:url => "trivektor", :title => "Tri Vuong's resume", :user_id => 1)
    
    resume_id = resume.id
    
    ResumePersonalInformation.create(:resume_id => resume_id, :full_name => "Tri Vuong")
    
    resume.destroy
    
    assert_equal nil, ResumePersonalInformation.find_by_resume_id(resume_id)
  end
  
  test "when a resume is deleted, its references should also be deleted" do
    resume = Resume.create(:url => "trivektor", :title => "Tri Vuong's resume", :user_id => 1)
    
    resume_id = resume.id
    
    ResumeReference.create(:resume_id => resume_id, :name => "Name", :title => "Title", :organization => "Organization", :email => "trivektor@gmail.com")
    
    resume.destroy
    
    assert_equal nil, ResumeReference.find_by_resume_id(resume_id)
  end
  
end
