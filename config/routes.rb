Rails.application.routes.draw do
  devise_for :users
  get 'courses/index'
  get 'users/index'
  get 'roles/index'


  root 'courses#index', as: 'home'

  #resources :users
  resources :courses
  resources :roles
end
