Rails.application.routes.draw do
  root 'tops#index'
  devise_for :users
  resources :users, only: [:show]
  resources :diaries, only: [:index]
  namespace :admin do
    resources :fishes
    resources :users
  end
  namespace :api do
    resources :fishes, only: [:index]
  end
end
