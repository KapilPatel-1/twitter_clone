Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  
  resources :tweets
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
