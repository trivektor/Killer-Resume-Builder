Krb::Application.routes.draw do
  
  root :to => 'home#index'
  
  #resources :users, :only => [:new, :create]
  
  match "/dashboard" => "dashboard#index"
  
    
  resources :user_sessions
    match "login" => "user_sessions#new", :as => :login
    match "logout" => "user_sessions#destroy", :as => :logout
  
  resources :users, :only => [:new, :create]
    match "signup" => "users#new", :as => :signup
  
  match "profiles/upload_photo" => "profiles#upload_photo"
  match "profiles/process_upload_photo" => "profiles#process_upload_photo"
  match "profiles/crop_photo" => "profiles#crop_photo"
  resources :profiles
  
  post "/thoughts/new"
  
  resources :blogs, :only => [:show, :index]
    match "/blogs/author/:name" => "blogs#author"
    match "/blogs/tag/:tag" => "blogs#tag"
  
  resources :user_threads
  
  # scope :path => "/resumes", :controller => :resumes do
  #       match "new" => :new
  #       match "edit/:id" => :edit
  #     end
  
  # match "/resumes/new" => "resumes#new"
  # match "/resumes/:id" => "resumes#update"
  # get "/resumes/:username" => "resumes#show" #http://url/resumes/trivektor ==> show the trivektor's resume  # @resume = Resume.find_by_username params[:username]
  
  resources :resumes do #, :only => [:new, :create, :update, :edit, :destroy] do
    
    member do
      get :delete
    end
    
    resources :resume_educations do
      member do
        get :delete
        #   /resumes/1/resume_educations/1/...
        get :toggle  #/resumes/1/resume_educations/1/toggle  -> params[:resume_id], params[:id],  toggle_resume_resume_education_path(@resume, @...)
      end
      
      # delete_all
      collection do
        # /resumes/1/resume_educations/...
        get :delete_all  #/resumes/1/resume_educations/delete_all  -> params[:resume_id],  delete_all_resume_resume_educations_path(@resume)
      end
      
    end
    
    resources :resume_work_experiences do
      member do
        get :delete
      end
    end
    
    resources :resume_references do
      member do
        get :delete
        post :order
      end
    end
    
  end
  
  resources :resume_settings do
    member do
      post :update
    end
  end
  
  resources :resume_keywords
  
  resources :resume_section_orders
  
  match "/ajax/sort_resume_sections" => "ajax#sort_resume_sections" # <--- dude, this is so PHP. ha ha
    
    # scope :path => "/resume_educations", :controller => :resume_educations do
    #   match "new/:id" => :new
    #   match "create/:id" => :create
    # end
  
  match "/:url" => "resumes#show"  
  match "/resume_references/order" => "resume_references#order"
  match "/resume_educations/order" => "resume_educations#order"
    
      
    
  #end
  
  #match "/signup" => "users#new"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
