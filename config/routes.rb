Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'
  get 'mycart', to: 'orders#cart', as: 'mycart'
  get 'myorders', to: 'orders#order', as: 'myorder'
  post 'addcart/:id', to: 'orders#create', as: 'add_cart'
  put 'inorder/:id', to: 'orders#update', as: 'inorder'
  get 'orders/:id/edit', to: 'orders#edit', as: 'edit_order'
  delete 'myorder/:id', to: 'orders#destroy', as: 'order'
  # get 'addtocart/:id', to: 'carts#newAddToCart', as: 'new_add_to_cart'
  # post 'addtocart/:id', to: 'carts#addToCart', as: 'add_to_cart'

  # get 'showcart/', to: 'orders#show', as: 'show_cart'
  # get 'editcart/:id/edit', to: 'orders#editCart', as: 'edit_cart'
  # put 'orderprod/:id', to: 'orders#update', as: 'update_orderprod'
# article_comments      GET      /articles/:article_id/comments(.:format)         comments#index
#                       POST     /articles/:article_id/comments(.:format)         comments#create
# new_article_comment   GET      /articles/:article_id/comments/new(.:format)     comments#new
# edit_article_comment  GET      /articles/:article_id/comments/:id/edit(.:format)comments#edit
# article_comment       GET      /articles/:article_id/comments/:id(.:format)     comments#show
#                       PATCH    /articles/:article_id/comments/:id(.:format)     comments#update
#                       PUT      /articles/:article_id/comments/:id(.:format)     comments#update
#                       DELETE   /articles/:article_id/comments/:id(.:format)     comments#destroy
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products
  # resources :orders
  # resources :carts
  # get 'tocart/:id', to: 'carts#create', as: 'to_cart'
  get "/fetch_products" => 'products#filter_products', as: 'fetch_products'

  root 'welcome#index'
end
