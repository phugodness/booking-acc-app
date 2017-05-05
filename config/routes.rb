Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  root to: 'home#index'

  devise_for :users, controllers: { registrations: :registrations, omniauth_callbacks: 'callbacks' }

  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => '/cable'

  post '/hook' => 'reservations#hook'
  get 'reservations/new'
  get 'home/index'
  get 'about/index'
  get 'about', to: 'about#index'
  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'search/index'

  as :user do
    get 'users/profile', to: 'devise/registrations#edit', as: :user_root
  end

  delete'/image_rooms/remove_image/:id' => 'image_rooms#remove_image', as: :remove_image

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  resources :rooms do
    resources :reviews
    collection do
      get 'images/:id' => 'rooms#images'
    end
  end
  resources :image_rooms
  resources :reservations
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
end
