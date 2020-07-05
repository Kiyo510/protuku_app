Rails.application.routes.draw do
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
end
