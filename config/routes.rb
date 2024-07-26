Rails.application.routes.draw do
  get 'profile/:user_id/photo', to: 'profile#photo', as: 'profile_photo'
  get 'profile/:user_id/album', to: 'profile#album', as: 'profile_album'
  get 'profile/:user_id/follower', to: 'profile#follower', as: 'profile_follower'
  get 'profile/:user_id/following', to: 'profile#following', as: 'profile_following'
  
  resources :albums
  
  resources :photos do
    resource :reaction, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  post 'follows/:id', to: 'follows#create', as: 'follow'
  delete 'follows/:id', to: 'follows#destroy', as: 'unfollow'
  resources :follows, only: [:create, :destroy]

  namespace :admin do
    root to: 'dashboard#index', as: 'root'
    resources :users
    resources :photos
    resources :albums
  end

  root 'home#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
