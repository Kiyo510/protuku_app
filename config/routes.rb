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
  resources :items do
    collection do
      get  'purchase/:id',to: 'items#purchase', as: 'purchase'
      post 'pay/:id',to:  'items#pay', as: 'pay'
      get  'done', to:    'items#done', as: 'done'
    end
  end
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:show, :create, :index]
  resources :stocks, only: %i(index create destroy)
  resources :account_activations, only: [:edit]
  resources :notifications, only: [:index]
  resources :password_resets,     only: [:new, :edit, :create, :update]
  resources :cards, only: [:new, :show] do
    collection do
    post 'show', to: 'cards#show'
    post 'pay', to: 'cards#pay'
    post 'delete', to: 'cards#delete'
    end
  end
end
