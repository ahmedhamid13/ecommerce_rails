Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'
  get 'addcart/:id', to: 'orders#create', as: 'add_cart'
  get 'addtocart/:id', to: 'carts#newAddToCart', as: 'new_add_to_cart'
  post 'addtocart/:id', to: 'carts#addToCart', as: 'add_to_cart'

  # get 'showcart/', to: 'orders#show', as: 'show_cart'
  # get 'editcart/:id/edit', to: 'orders#editCart', as: 'edit_cart'
  # put 'orderprod/:id', to: 'orders#update', as: 'update_orderprod'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products
  resources :orders
  resources :carts
  # get 'tocart/:id', to: 'carts#create', as: 'to_cart'

  root 'welcome#index'
end
