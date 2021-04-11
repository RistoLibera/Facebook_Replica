Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'users/show'
  get 'users/update'
root to: "posts#index"  
devise_for :users
resources :posts
resources :comments
resources :likings
resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
