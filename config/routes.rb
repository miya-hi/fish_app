Rails.application.routes.draw do
  get 'users/show'
  root 'tops#index'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
  get '/tops/help', to: 'tops#help'
  resources :users, only: [:show]
  resources :diaries, only: [:index]
  namespace :admin do
    resources :fishes
    resources :users, only: [:index]
  end
  namespace :api do
    resources :fishes, only: [:index]
  end
end
