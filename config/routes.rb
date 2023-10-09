Rails.application.routes.draw do
  devise_for :users, controllers: { 
    omniauth_callbacks: 'omniauth_callbacks'
  }
  resources :ai_components do
    scope module: :ai_components do
      resources :additions, only: [:create]
    end
  end
  resource :dashboard, only: [:show], controller: :show
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#show"
end
