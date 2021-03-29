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


  resources :achievements
  resources :readeds


  resources :courses do
    member do
      patch :to_publish
      post :subscribe
      delete :unsubscribe
    end

    resources :testings do
      resources :questions do
        resources :responses
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
  resources :pictures, only: [:create, :destroy]
  resources :organizations
  resources :roles
end