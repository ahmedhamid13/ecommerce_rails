Rails.application.routes.draw do
  resources :orders
  devise_for :users
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products
  resources :orders
  root 'welcome#index'
end
