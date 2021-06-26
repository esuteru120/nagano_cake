Rails.application.routes.draw do
  devise_for :admin, controllers: {
  sessions: 'admin/sessions'
  }
  root :to => 'admin/homes#top'
  devise_for :customers, controllers: {
  sessions: 'public/sessions',registrations: 'public/registrations'
  }
  
  namespace :admin do
  resources :admins
  resources :products
  resources :customers
  resources :orders
  resources :genres
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
  get "about", as:'about', to:'homes#about'
  
  end
  
 
  #get "about" => 'public/homes#about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
