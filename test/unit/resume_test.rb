require 'test_helper'

class ResumeTest < ActiveSupport::TestCase
  
  test "save resume with no title and no url" do
    resume = Resume.new
    assert !resume.save
  end
  
  test "save resume with a title and a url" do
    resume = Resume.new(:url => "trivektor", :title => "Tri Vuong's resume", :user_id => @current_user.id)
    resume.save
    assert_equal resume.url, "trivektor"
    assert_equal resume.title, "Tri Vuong's resume"
    assert_equal resume.user_id, @current_user.id
  end
  
end
