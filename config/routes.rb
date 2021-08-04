Rails.application.routes.draw do
  root 'tops#index'
  get 'tops/index'
  devise_for :users
  resources :users, only: [:show]
end
