Krb::Application.routes.draw do
    
  get "git/status"

  resources :user_sessions
    match "login" => "user_sessions#new", :as => :login
    match "logout" => "user_sessions#destroy", :as => :logout
  
  resources :users, :only => [:new, :create, :edit, :update]
    match "signup" => "users#new", :as => :signup
    match "registration_complete" => "users#registration_complete", :as => :registration_complete
    
  match '/auth/:provider/callback', :to => 'sessions#create'
  
  match "invalid_activation_code" => "activations#invalid_activation_code", :as => :invalid_activation_code
  match "activated" => "activations#activated", :as => :activated
  match "activate/:activation_code" => "activations#create", :as => :activation
  match "send_activation/:user_id" => "users#send_activation"
  match "profiles/upload_photo" => "profiles#upload_photo"
  match "profiles/process_upload_photo" => "profiles#process_upload_photo"
  match "profiles/crop_photo" => "profiles#crop_photo"
  match "profiles/hide_profile_notice" => "profiles#hide_profile_notice"
  
  resources :profiles
  
  resources :thoughts, :only => [:create]
  
  resources :blogs, :only => [:show, :index]
    match "/blogs/author/:name" => "blogs#author"
    match "/blogs/tag/:tag" => "blogs#tag"
  
  resources :user_threads do
    member do
      post :report_comment
      post :remove_comment
    end
  end
  
  resources :resumes do
    
    member do
      get :delete
      get :select_theme
    end
    
    resources :resume_educations do
      member do
        get :delete
        get :toggle
      end
      
      collection do
        post :order
        get :delete_all
      end
      
    end
    
    resources :resume_work_experiences do
      member do
        get :delete
      end
      
      collection do
        post :order
      end
    end
    
    resources :resume_references do
      member do
        get :delete
        post :order
      end
      
      collection do
        post :order
      end
    end
    
    resources :resume_hidden_fields do
      collection do
        post :update_section
      end
    end
    
    resources :resume_section_orders do
      collection do
        put :update_order
      end
    end
    
    resources :resume_themes, :only => [:update]
    
    resources :resume_settings, :only => [:update]
    
    resources :resume_keywords, :only => [:create, :destroy]
    
  end
  
  resources :password_resets
  
  root :to => 'home#index'

  match "/users" => "home#index"
  match "/dashboard" => "dashboard#index"
  
  match "/:url" => "resumes#show"  
    
end
