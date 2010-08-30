Jobware::Application.routes.draw do
  match "track" => Tracker.action(:track), :as => :tracker

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

  resources :jobs do
    member do
      post :star
      get :star
      put :star
    end
    resources :job_applications
  end

  resources :companies

  ### dashboard rewrite
  match "/jobseeker/dashboard" => "dashboard#jobseeker", :as => :jobseeker_dashboard
  match "/company/dashboard" => "dashboard#company", :as => :company_dashboard
  match "/partner/dashboard" => "dashboard#partner", :as => :partner_dashboard

  ### company section
  namespace :company do
    # resources :starred_resumes
    resource :company
    resources :jobs
    resources :job_applications do
      member do
        post :star
        get :star
        put :star
      end
    end
    resources :presentations
    resources :products
    # resources :ads
    # resources :services do
    #   member do
    #     post => :buy
    #   end
    # end
  end

  ### job seeker section
  namespace :jobseeker do
    resources :job_applications
    resources :starred_jobs
  #   resource :subscription

    resource :resume do
      resources :previous_jobs
      resources :schools
      resources :projects
      resources :skills
      resources :certifications
      resources :languages
      resources :cover_letters
    end

  #   resources :services do
  #     member do
  #       post :buy
  #     end
  #   end
  end

  ### partner section
  resource :partner
  namespace :partner do
    resources :ad_positions do
      # revenuess :counters
    end
    # resources :revenues
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
  match "/" => "page#home", :as => :root

  match ':controller(/:action(/:id(.:format)))'
end
