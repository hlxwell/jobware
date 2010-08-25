Jobware::Application.routes.draw do

  resources :"projects"

  ### auth stuff
  match "/login" => "sessions#new", :as => :login
  match "/logout" => "sessions#destroy", :as => :logout
  match "/signup" => "users#new", :as => :signup
  match "/forgot_password" => "sessions#forgot_password", :as => :forgot_password

  resource :sessions do
    member do
      get :forgot_password
      post :send_reset_password_mail
    end
  end

  resources :users do
    # resources :transactions
    # resources :credit_transactions
  end

  # ### basic frontend
  # resources :ads do
  #   member do
  #     get :job_board
  #   end
  # end

  resources :companies do
    resources :jobs do
      post :star
    end
  end

  ### dashboard rewrite
  match "/dashboard" => "dashboard#jobseeker", :as => :jobseeker_dashboard
  match "/company/dashboard" => "dashboard#company", :as => :company_dashboard
  match "/partner/dashboard" => "dashboard#partner", :as => :partner_dashboard

  ### company section
  namespace :company do
    resources :jobs
    # resources :job_applications
    # resources :starred_resumes
    # resources :presentations
    # resources :products
    # resources :ads
    # resources :services do
    #   member do
    #     post => :buy
    #   end
    # end
  end

  ### job seeker section
  namespace :jobseeker do
  #   resources :job_applications
  #   resources :starred_jobs
  #   resource :subscription
  #
    resource :resume do
      resources :previous_jobs
      resources :schools
      resources :projects
      resources :skills
      resources :certifications
      resources :languages
      resources :cover_letters
    end
  #
  #   resources :services do
  #     member do
  #       post :buy
  #     end
  #   end
  end

  ### partner section
  resource :partner
  namespace :partner do
    resources :ad_positions
    # resources :revenues
    # revenuess :counters
  end

  # ### admin section
  # namespace :admin do
  #   resources :jobs
  #   resources :companies
  #   resources :resumes
  #   resources :job_applications
  #   resources :subscriptions
  #   resources :partners
  #   resources :users
  #   resources :services
  #   resources :ad_positions
  #   resources :transactions
  #   resources :credit_transactions
  # end
  #
  # ### SEO
  # match "/sitemap.xml" => "sitemap#index"
  # match "/sitemap.xml.gz" => "sitemap#zip"

  ### root
  match "/" => "home#aaa", :as => :root

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  # root :to => redirect("home#index")

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
