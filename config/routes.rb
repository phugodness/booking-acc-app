Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
  get 'home/index'

  get 'about/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'about', to: 'about#index'
  root to: "home#index"
  as :user do
    get 'users/profile', :to => 'devise/registrations#edit', :as => :user_root
  end
end
