Rails.application.routes.draw do
  get 'organizations/index'
  devise_for :users, controllers: {registrations: 'users' }
  get 'courses/index'
  get 'users/index'
  get 'roles/index'

  get 'users/:id' => 'users#show'

  root 'courses#index', as: 'home'

  resources :users
  resources :courses
  resources :organizations
  resources :roles

end
