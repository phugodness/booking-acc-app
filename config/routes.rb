Rails.application.routes.draw do
  get 'search/index'

  root to: 'home#index'

  devise_for :users, controllers: { registrations: :registrations, omniauth_callbacks: 'callbacks' }

  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => '/cable'

  post '/hook' => 'reservations#hook'
  get 'reservations/new'
  get 'home/index'
  get 'about/index'
  get 'about', to: 'about#index'

  as :user do
    get 'users/profile', to: 'devise/registrations#edit', as: :user_root
  end

  resources :rooms do
    resources :reviews
  end
  resources :reservations
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
end
