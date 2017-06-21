class UserSession < Authlogic::Session::Base
  
  def remember_me_for
    2.weeks
  end
  
end
