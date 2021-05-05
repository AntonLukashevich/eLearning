# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:todo Metrics/BlockLength
  require 'sidekiq/web'

  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app

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
  resources :admins do
    get 'users', on: :collection
    get 'courses', on: :collection
    get 'organizations', on: :collection
    member do
      post :nominate
      post :fire
    end
  end

  resources :organizations do
    member do
      patch :response_to_request
    end
    resources :managers
  end
  resources :answers
  resources :users

  resources :achievements do
    member do
      get :certificate
    end
  end
  resources :readeds

  resources :courses do
    resources :individuals
    member do
      patch :to_publish
      patch :request_to
      patch :to_draft
      post :subscribe
      delete :unsubscribe
      get :authors
      post :new_author
      delete :delete_author
    end

    collection do
      get :my_courses
      get :publications
    end

    resources :testings do
      member do
        get :pass_testing
        delete :retake
      end
      resources :questions do
        resources :responses do
        end
      end
    end

    resources :lectures do
      member do
        patch :move
        post :readed
      end
    end
  end

  resources :youtube
  resources :pictures, only: %i[create destroy]
  resources :organizations
  resources :roles


end
