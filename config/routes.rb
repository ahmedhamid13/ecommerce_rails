Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'
  get 'addtocart/:id', to: 'orders#create', as: 'add_to_cart'
  get 'showcart/', to: 'orders#showCart', as: 'show_cart'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products
  root 'welcome#index'
end
