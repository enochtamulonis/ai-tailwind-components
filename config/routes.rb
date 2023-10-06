Rails.application.routes.draw do
  resources :ai_components
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "ai_components#index"
end
