Timetracker::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }

  resources :dashboard

  resources :accounts

  resources :subscriptions do
    get :confirm_subscription, :on => :collection
    get :cancel, :on => :collection
  end

  resources :company

  resources :company_users, :except => [:index, :edit, :update]

  resources :projects do
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
  resources :support
  match 'support' => 'support#create', :as => 'support', :via => :post

  root :to => "home#index"
  match 'home/plans' => 'home#plans'
end