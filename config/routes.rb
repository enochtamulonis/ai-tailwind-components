Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'omniauth_callbacks'
  }
  resources :ai_components, only: [:create, :show, :index] do
    scope module: :ai_components do
      resources :additions, only: [:create]
    end
  end
  resources :subscriptions, only: [:new, :create, :edit]
  namespace :subscriptions do
    resource :payment_intent, only: [:create], controller: 'payment_intent'
    resource :success, only: [:show], controller: "success"
    resource :cancel, only: [:create], controller: "cancel"
  end
  namespace :users do
    resource :deactivate, only: [:show], controller: :deactivate
  end
  resource :dashboard, only: [:show], controller: :show
  post "/webhook_events/:source", to: "webhook_events#create"
  get "/admin", to: "admins#index"
  namespace :admins do
    resources :users, only: [:index]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#show"
end
