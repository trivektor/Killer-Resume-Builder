class HomeController < ApplicationController
  
  def index
    params[:body_id] = "home"
  end
  
end
