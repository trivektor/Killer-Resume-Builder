class SessionsController < ApplicationController
  
  def create
    auth = request.env['omniauth.auth']
    
    activate_authlogic
    
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    
    # Log the authorizing user in.
    self.current_user = @auth.user
    
    redirect_to dashboard_path and return
    
    render :text => ''
  end
  
end
