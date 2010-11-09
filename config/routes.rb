Jobware::Application.routes.draw do
  get "alipay/pay"
  post "alipay/notify"
  get "alipay/done"
  get "alipay/error"

  match "/inline_widget" => "ads#inline_widget"
  # match "track" => Tracker.action(:track), :as => :tracker
  # match "slideshowpro(.:format)" => "pages#slideshowpro"
  match "/partner_benifit" => "pages#partner_benifit"
  match "/company_benifit" => "pages#company_benifit"
  match "/aboutus" => "pages#aboutus"
  match "/partner_site_header" => "partners#partner_site_header"
  match "/partner_site_footer" => "partners#partner_site_footer"
  match "/law" => "pages#law"
  match "/contactus" => "pages#contactus"
  match "/term" => "pages#term"
  match "/ad_service" => "pages#ad_service"
  match "/recruiter_service" => "pages#recruiter_service"

  ### auth stuff
  match "/login" => "sessions#new", :as => :login
  match "/logout" => "sessions#destroy", :as => :logout
  match "/signup" => "users#new", :as => :signup
  match "/reset_password(.:format)" => "sessions#reset_password", :as => :reset_password
  match "/edit_password/:id" => "sessions#edit_password", :as => :edit_password
  match "/update_password" => "sessions#update_password", :as => :update_password
  match "/email_confirmation/(:id)" => "sessions#email_confirmation", :as => :email_confirmation
  match "/resend_confirmation" => "sessions#resend_confirmation", :as => :resend_confirmation

  resource :user

  resource :sessions do
    member do
      get :forgot_password
      post :send_reset_password_mail
    end
  end

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
      get :filter
      post :search
      get :search
    end
    resources :job_applications
  end

  resources :companies do
    member do
      get :presentations
      get :all_jobs
    end

    collection do
      get :filter
      get :created
    end
  end


  ### dashboard rewrite
  match "/jobseeker/dashboard" => "dashboard#jobseeker", :as => :jobseeker_dashboard
  match "/company/dashboard" => "dashboard#company", :as => :company_dashboard
  match "/partner/dashboard" => "dashboard#partner", :as => :partner_dashboard

  ### company section
  namespace :company do
    resources :transactions do
      collection do
        get :notify
        get :done
      end
    end

    resources :starred_resumes
    resource :company

    resources :jobs do
      member do
        get :close
        get :open
        get :reactive
        get :get_options
        get :want_to_show
      end
    end

    resources :job_applications do
      member do
        post :star
        get :star
        put :star
        put :accept
        put :reject
      end
    end

    resources :presentations
    resources :products

    resources :ads do
      member do
        get :want_to_show
      end

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
      member do
        get :created
        get :new_with_choices
      end

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
  resource :partner do
    member do
      get :created
    end
  end

  namespace :partner do
    resource :partner_site_style
    resource :code do
      member do
        get :update_widget_js_code
      end
    end
    resources :ad_positions do
      resources :counters
    end
    resources :revenues
    resources :transactions do
      collection do
        get :income
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
