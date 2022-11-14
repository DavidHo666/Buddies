Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :events
  resources :participations
  get 'events/index'
  root 'events#index'
  get 'users/index'
  post 'events/:id/participate', to: 'events#add_participation', as: 'participate_event'
  delete 'events/:id/participate', to: 'events#remove_participation', as: 'unparticipate_event'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
