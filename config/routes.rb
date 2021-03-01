Rails.application.routes.draw do
  get 'lecture_blocks/index'
  get 'lectures/index'
  get 'organizations/index'
  devise_for :users, controllers: {registrations: 'users' }
  get 'courses/index'
  get 'users/index'
  get 'roles/index'

  get 'users/:id' => 'users#show'

  root 'courses#index', as: 'home'

  resources :users

  resources :courses do
    #resources :course_blocks
    resources :lectures do
      collection do
        patch :sort
      end
        resources :lecture_blocks
    end
  end

  resources :pictures, only: [:create, :destroy]

  # resources :courses do
  #     resources :lectures, controller: 'lectures', type: 'Lecture' do
  #       resources :lecture_blocks
  #     end
  # end

  resources :organizations
  resources :roles


  #resources :lectures


  #resources :lecture_blocks
  #resources :text_content, controller: 'lecture_blocks', type: 'TextContent'


end
