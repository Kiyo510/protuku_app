Rails.application.routes.draw do
  root 'home#home'
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, expect: :index
  resources :items
  resources :messages, only: %i(create destroy)
  resources :rooms, only: %i(show create index)
  resources :stocks, only: %i(index create destroy)
  resources :account_activations, only: %i(edit)
  resources :notifications, only: %i(index)
  resources :password_resets, only: %i(new edit create update)
end
