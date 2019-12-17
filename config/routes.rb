Rails.application.routes.draw do
  devise_for :users
  root "messages#index"
  resources :users, only: [:edit, :update]
  resources :groups, only: [:create, :edit, :update]
  resources :groups_users, only: [:create, :update]
end
