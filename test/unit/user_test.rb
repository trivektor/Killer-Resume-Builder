require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "save user with empty attributes" do
    user = User.new
    assert !user.valid?
  end
  
  test "save user with invalid username" do
    user = User.new(:username => "a", :email => "trivektor@gmail.com", :password => "abcd")
    assert !user.valid?
  end
  
  test "save user with invalid email" do
    user = User.new(:username => "trivektor", :email => "trivektor@", :password => "abcd")
    assert !user.valid?
    user = User.new(:username => "trivektor", :email => "trivuong@gmailcom", :password => "abcd")
    assert !user.valid?
    user = User.new(:username => "trivektor", :email => "trivektor", :password => "abcd")
    assert !user.valid?
    user = User.new(:username => "trivektor", :email => "tri!@$%$^vuong@gmail.com", :password => "abcd")
    assert !user.valid?
  end
  
  test "save user with valid email" do
    user = User.new(:username => "trivektor", :email => "tri.vuong@us.penguingroup.com", :password => "asdadasdasd")
    assert user.valid?
  end
  
  test "save user with valid with valid attributes" do
    user = User.new(:username => "trivektor", :email => "trivektor@gmail.com", :password => "abcd")
    assert user.valid?
  end
  
end
