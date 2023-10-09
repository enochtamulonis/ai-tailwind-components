Rails.application.routes.draw do
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
