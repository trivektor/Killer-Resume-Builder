require 'test_helper'

class UserControllerTest < ActionController::TestCase
  
  def setup()
    
  end
  
  test "should create profile when a new user is created" do
    @user = User.new(:username => "trivektor", :email => "trivektor@gmail.com", :password => "abcd")
    @user.save
    @profile = Profile.new
    @profile.user = @user
    @profile.save
  end
  
end
