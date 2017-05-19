Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root to: 'home#index'

  devise_for :users, controllers: { registrations: :registrations, omniauth_callbacks: 'callbacks' }

  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => '/cable'

  get 'reservations/new'
  get 'home/index'
  get 'about/index'
  get 'about', to: 'about#index'
  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'search/index'
  post '/hook' => 'reservations#hook'
  post 'phone_numbers/verify' => "phone_numbers#verify"
  get 'approve_reservations', to: 'reservations#approve_reservations'
  as :user do
    get 'users/profile', to: 'devise/registrations#edit', as: :user_root
  end

  get 'users/:id' => 'users#show', as: :user

  delete'/image_rooms/remove_image/:id' => 'image_rooms#remove_image', as: :remove_image

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  resources :phone_numbers, only: [:new, :create]
  resources :image_rooms
  resources :reservations
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
  resources :rooms do
    resources :reviews
    collection do
      get 'images/:id' => 'rooms#images'
    end
  end
end
