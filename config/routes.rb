Rails.application.routes.draw do

  get 'reservations/new'

  resources :rooms do
    resources :reviews
  end
  resources :reservations
  devise_for :users, :controllers => { :registrations => :registrations, :omniauth_callbacks => "callbacks"  }
  get 'home/index'
  get 'about/index'
  mount Ckeditor::Engine => '/ckeditor'
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'about', to: 'about#index'
  root to: "home#index"
  as :user do
    get 'users/profile', :to => 'devise/registrations#edit', :as => :user_root
  end
  resources :personal_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
end
