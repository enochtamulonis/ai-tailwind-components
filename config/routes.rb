Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'omniauth_callbacks'
  }
  resources :ai_components, only: [:create, :show, :index, :destroy] do
    scope module: :ai_components do
      resources :additions, only: [:create]
      resources :edit_code, only: [:new, :create], controller: :edit_code
    end
  end
  resources :subscriptions, only: [:new, :create, :edit]
  namespace :subscriptions do
    resource :payment_intent, only: [:create], controller: 'payment_intent'
    resource :success, only: [:show], controller: "success"
    resource :cancel, only: [:create], controller: "cancel"
  end
  resource :purchase, only: [:new], controller: :purchase

  namespace :purchase do
    resource :payment_intent, only: [:create], controller: 'payment_intent'
    resource :success, only: [:show], controller: "success"
  end

  namespace :users do
    resource :deactivate, only: [:show], controller: :deactivate
  end
  resources :users do
    scope module: :users do
      resource :unsubscribe_email, only: [:create, :show], controller: "unsubscribe_email"
    end
  end
  resource :dashboard, only: [:show], controller: :show
  post "/webhook_events/:source", to: "webhook_events#create"
  get "/admin", to: "admins#index"
  namespace :admins do
    resources :users, only: [:index] do
      post "listen_to_subscription", to: "users#listen_to_subscription"
      post "ignore_subscription", to: "users#ignore_subscription"
    end
    resources :component_packs do
      post "make_featured", to: "component_packs#make_featured"
      post "turn_off_featured", to: "component_packs#turn_off_featured"
      scope module: :component_packs do
        resources :ai_components, only: [:create]
      end
    end
    resources :emails, only: [:new, :create, :index]
    resources :ai_components, only: [:index, :show]
  end
  resources :free_component_packs, only: [:show]
  resource :sign_in_modal, only: [:create], controller: 'sign_in_modal'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#show"
end
