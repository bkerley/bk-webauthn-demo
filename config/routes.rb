Rails.application.routes.draw do
  get 'dashboard/index', as: 'dashboard'
  root 'sessions#new'

  resource :sessions
  resource :users
  resources :credentials, only: %i{new create destroy} do
    post :callback, on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
