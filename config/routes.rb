Rails.application.routes.draw do
  get 'credentials/new'
  get 'dashboard/index', as: 'dashboard'
  root 'sessions#new'

  resource :sessions
  resource :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
