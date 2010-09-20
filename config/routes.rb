Jobware::Application.routes.draw do
  match "track" => Tracker.action(:track), :as => :tracker
  match "slideshowpro(.:format)" => "pages#slideshowpro"
  match "/partner_benifit" => "pages#partner_benifit"
  match "/company_benifit" => "pages#company_benifit"
  match "/aboutus" => "pages#aboutus"
  match "/partner_site_header" => "partners#partner_site_header"
  match "/partner_site_footer" => "partners#partner_site_footer"
  match "/services" => "pages#services"
  match "/contactus" => "pages#contactus"

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

  resource :user

  ### basic frontend
  resources :ads do
    member do
      get :job_board
    end
  end

  resources :jobs do
    resources :companies, :only => [:show] do
      member do
        get :all_jobs
      end
    end

    member do
      post :star
      get :star
      put :star
    end

    collection do
      post :search
    end

    resources :job_applications
  end

  resources :companies do
    member do
      get :presentations
      get :all_jobs
    end
  end

  ### dashboard rewrite
  match "/jobseeker/dashboard" => "dashboard#jobseeker", :as => :jobseeker_dashboard
  match "/company/dashboard" => "dashboard#company", :as => :company_dashboard
  match "/partner/dashboard" => "dashboard#partner", :as => :partner_dashboard

  ### company section
  namespace :company do
    resources :transactions
    resources :starred_resumes
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
    resources :ads do
      collection do
        get :plans
      end
    end
    resources :services do
      member do
        get :buy
        get :bought
      end

      collection do
        get :bought
      end
    end
  end

  ### job seeker section
  namespace :jobseeker do
    resources :transactions
    resources :job_applications
    resources :starred_jobs
    resource :subscription

    resource :resume do
      resources :previous_jobs
      resources :schools
      resources :projects
      resources :skills
      resources :certifications
      resources :languages
      resources :cover_letters
    end

    resources :services do
      member do
        get :buy
      end

      collection do
        get :bought
      end
    end
  end

  ### partner section
  resource :partner
  namespace :partner do
    resource :partner_site_style
    resource :code
    resources :ad_positions do
      resources :counters
    end
    resources :revenues
    resources :transactions do
      collection do
        get :withdraw
      end
    end
  end

  # ### SEO
  # match "/sitemap.xml" => "sitemap#index"
  # match "/sitemap.xml.gz" => "sitemap#zip"

  ### root
  match "/" => "ads#index", :as => :root

  # match ':controller(/:action(/:id(.:format)))'
end
