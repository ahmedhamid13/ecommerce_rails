Rails.application.routes.draw do
  get 'store_orders/index'
  get 'store/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'
  
  resources :products

  ### Cart Routes
  get 'carts', to: 'carts#index', as: 'carts'
  delete 'remove.product/:id', to: 'carts#remove', as: 'remove_product'
  post 'add.to.cart/:id', to: 'carts#create', as: 'add_to_cart'
  put 'cart/:id', to: 'carts#update', as: 'cart'

  ### Order Routes
  get 'orders', to: 'orders#index', as: 'orders'
  get 'order/:id/edit', to: 'orders#edit', as: 'edit_order'
  put 'order/:id', to: 'orders#update', as: 'order'


  ### Store_Orders Routes
  get 'store.orders', to: 'store_orders#index', as: 'store_orders'
  put 'store.response/:id', to: 'store_orders#update', as: 'store_response'

  get "/fetch_products" => 'products#filter_products', as: 'fetch_products'

  root 'welcome#index'
end
