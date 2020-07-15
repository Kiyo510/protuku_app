Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'password_reset/new'
  get 'password_reset/edit'
  get 'rooms/index'
  get 'rooms/show'
  root 'home#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :items
  resources :messages, only: [:create]
  resources :rooms, only: [:show, :create]
  resources :stocks, only: %i(index create destroy)
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :edit, :create, :update]
end
