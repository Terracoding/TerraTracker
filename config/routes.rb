Timetracker::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => { :registrations => :registrations }

  resources :dashboard
  resources :features, :only => :index
  resources :accounts

  resources :subscriptions do
    get :confirm_subscription, :on => :collection
    get :cancel, :on => :collection
  end

  resources :company
  resources :company_users, :except => [:index, :edit, :update]

  resources :projects do
    resources :tasks
    resources :users, :controller => :project_users
    get :archived, :on => :collection
  end

  resources :tasks

  resources :timeslips do
    post :get_tasks, :on => :collection
    post :get_users, :on => :collection
  end
  match "/timeslips/:year/:month/:day" => "timeslips#index", :as => "timeslips_date"

  resources :reports do
    post :generate_report, :on => :collection
    post :view_report, :on => :collection
  end

  resources :webhooks, :only => [:receive_payload] do
    post :receive_payload, :on => :collection
  end

  resources :bills
  resources :support do
    get :privacy, :on => :collection
  end
  match 'support' => 'support#create', :as => 'support', :via => :post
  resources :developer

  root :to => "home#index"
  match 'home/plans' => 'home#plans'

  # API
  namespace :api do
    namespace :v1 do
      post 'login' => 'users#login'
    end
  end

end