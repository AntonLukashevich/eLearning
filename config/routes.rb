Rails.application.routes.draw do
  get 'lecture_blocks/index'
  get 'lectures/index'
  get 'organizations/index'
  devise_for :users, controllers: { registrations: 'users' }
  get 'courses/index'
  get 'users/index'
  get 'roles/index'
  get 'answers/index'

  get 'users/:id' => 'users#show'

  root 'courses#index', as: 'home'
  resources :answers
  resources :users
  resources :courses do

    member do
      patch :to_publish
    end

    resources :testings do
      resources :questions do

      end
    end

    resources :lectures do
      member do
        patch :move
      end
    end
  end

  resources :youtube
  resources :pictures, only: [:create, :destroy]
  resources :organizations
  resources :roles
end