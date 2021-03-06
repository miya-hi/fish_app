Rails.application.routes.draw do
  get 'users/show'
  root 'tops#index'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
  get '/tops/help', to: 'tops#help'
  devise_scope :user do
      post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
      post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end
  resources :users, only: [:index, :show]
  resources :diaries
  resources :favorites, only: [:index, :destroy]
  resources :fishes, only: [:index]
  namespace :admin do
    resources :fishes
    resources :users, only: [:index, :edit, :update]
  end
  namespace :api do
    resources :fishes, only: [:index, :show]
  end
end
