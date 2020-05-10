Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'
  get 'mycart', to: 'orders#cart', as: 'mycart'
  get 'myorders', to: 'orders#buyer_order', as: 'myorder'
  get 'storeorders', to: 'orders#store_order', as: 'mystore'
  post 'addcart/:id', to: 'orders#addToCart', as: 'add_cart'

  get 'setorder/', to: 'orders#set', as: 'set_order'
  put 'putorder/', to: 'orders#putorder', as: 'put_order'
  put 'approve/:id', to: 'orders#approve', as: 'approve'
  put 'cancel/:id', to: 'orders#cancel', as: 'cancel'

  delete 'delorder/:id', to: 'orders#destroy', as: 'del_order'
  delete 'remproduct/:id', to: 'orders#remove', as: 'rem_product'

  # get 'addtocart/:id', to: 'carts#newAddToCart', as: 'new_add_to_cart'
  # post 'addtocart/:id', to: 'carts#addToCart', as: 'add_to_cart'

  resources :products
  # resources :orders
  # resources :carts
  get "/fetch_products" => 'products#filter_products', as: 'fetch_products'

  root 'welcome#index'
end
