Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'
  get 'mycart', to: 'orders#cart', as: 'mycart'
  get 'myorders', to: 'orders#order', as: 'myorder'
  post 'addcart/:id', to: 'orders#addToCart', as: 'add_cart'
  put 'inorder/:id', to: 'orders#update', as: 'inorder'
  get 'orders/:id/edit', to: 'orders#edit', as: 'edit_order'
  delete 'myorder/:id', to: 'orders#destroy', as: 'order'
  # get 'addtocart/:id', to: 'carts#newAddToCart', as: 'new_add_to_cart'
  # post 'addtocart/:id', to: 'carts#addToCart', as: 'add_to_cart'

  resources :products
  # resources :orders
  # resources :carts
  get "/fetch_products" => 'products#filter_products', as: 'fetch_products'

  root 'welcome#index'
end
