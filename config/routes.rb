Rails.application.routes.draw do

  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'products#index'
  get 'on_sale' => 'products#on_sale', as: 'on_sale'
  get 'recent_updates' => 'products#recent_updates', as: 'recent_updates'
  get 'search_results' => 'products#search_results', as: 'search_results'

  get 'orders/past_orders', to: 'orders#past_orders', as: 'past_orders'
  get  'orders/checkout', to: 'orders#checkout', as: 'checkout'
  post 'orders/create_orders', to: 'orders#create_orders', as: 'create_orders'
  get 'orders/purchase_confirmation', to: 'orders#purchase_confirmation', as: 'purchase_confirmation'

  post 'cart/update_quantity', to: 'cart#update_quantity', as: 'update_quantity'
  post 'cart/remove', to: 'cart#remove', as: 'remove'

  post 'products/add_to_cart', to: 'products#add_to_cart', as: 'add_to_cart'
  post 'products/remove_from_cart', to: 'products#remove_from_cart', as: 'remove_from_cart'

  get 'about' => 'about#index', as: 'about'
 
  resources :products, :orders, :customers, :deliveries, :categories, :cart, :about


end
