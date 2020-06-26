Rails.application.routes.draw do
  root 'home#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users
end
