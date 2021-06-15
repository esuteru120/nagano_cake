Rails.application.routes.draw do
  namespace :admin do
  resources :admins
  
  end
  
  scope module: :public do
  resources :customers
  resources :addresses
  resources :items
  resources :genres
  resources :cart_items
  resources :orders
  resources :order_details
  get 'customers/quit'
  patch 'customers/out'
  delete "cart_items/destroy_all", to: 'cart_items#destroy_all'
  get 'orders/log'
  get 'orders/thanx'

  end
  
 devise_for :admin, controllers: {
  sessions: 'admin/sessions'
}
  root :to => 'public/homes#top'
  get "about" => 'public/homes#about'
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
