Rails.application.routes.draw do
  root 'tops#index'
  devise_for :users
  resources :users, only: [:show]
  resources :diaries, only: [:index]
  namespace :admin do
    resources :fishes
  end
end
