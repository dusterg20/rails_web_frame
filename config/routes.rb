Rails.application.routes.draw do

  get 'access_permissions/new'
  get 'access_permissions/edit'
  get 'access_permissions/index'
  get 'access_permissions/show'
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

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :rpis
  resources :devices
  resources :access_controls
  resources :access_control_doors
  resources :access_permissions
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
