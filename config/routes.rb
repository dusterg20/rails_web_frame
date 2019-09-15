Rails.application.routes.draw do

  get 'control_action/action'
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get   '/controls', to: 'controls#home'
  get   '/action',   to: 'controls#action'
  get   '/devices',   to: 'devices#index'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :devices, only: [:new, :create, :update, :edit, :index, :show, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
