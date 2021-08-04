Rails.application.routes.draw do
  get 'tops/index'
  devise_for :users
# root 'tops#index'
  resources :users, only: [:show]
end
