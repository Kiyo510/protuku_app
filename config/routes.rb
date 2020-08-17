Rails.application.routes.draw do
  root 'home#home'
  post '/', to: 'users#create'
  get 'purchase_histories/index'
  get 'cards/new'
  get 'cards/show'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'password_reset/new'
  get 'password_reset/edit'
  get 'rooms/index'
  get 'rooms/show'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :items do
    collection do
      get  'purchase/:id',to: 'items#purchase', as: 'purchase'
      post 'pay/:id',to:  'items#pay', as: 'pay'
      get  'done', to:    'items#done', as: 'done'
    end
  end
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:show, :create]
  resources :stocks, only: %i(index create destroy)
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :edit, :create, :update]
  resources :cards, only: [:new, :show] do
    collection do
    post 'show', to: 'cards#show'
    post 'pay', to: 'cards#pay'
    post 'delete', to: 'cards#delete'
    end
  end
end
