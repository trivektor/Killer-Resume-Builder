require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "save user with capitalized first name and last name" do
    
    user = User.new(:first_name => "TRI", :last_name => "VUONG", :username => "trivektor", :email => "trivektor@gmail.com", :password => "abcd")
    user.save
    user.profile = Profile.new(:first_name => user.first_name, :last_name => user.last_name)
    user.profile.save
  
    assert_equal "Tri", user.profile.first_name
    assert_equal "Vuong", user.profile.last_name
    
  end
  
end
