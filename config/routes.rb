Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :events
  get 'events/index'
  root 'events#index'
  get 'users/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
