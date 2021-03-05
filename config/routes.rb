Rails.application.routes.draw do
  get 'lecture_blocks/index'
  get 'lectures/index'
  get 'organizations/index'
  devise_for :users, controllers: { registrations: 'users' }
  get 'courses/index'
  get 'users/index'
  get 'roles/index'

  get 'users/:id' => 'users#show'

  root 'courses#index', as: 'home'

  resources :users
  resources :courses do
    # #resources :course_blocks
    # resources :course_tests, :path =>'course_block' do
    #   resources :radio_questions
    #   resources :answers
    # end
    #
    resources :testings

    resources :lectures do
      member do
        patch :move
      end
    end
  end

  resources :pictures, only: [:create, :destroy]
  resources :organizations
  resources :roles
end