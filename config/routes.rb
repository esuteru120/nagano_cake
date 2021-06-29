Rails.application.routes.draw do
  devise_for :admin, controllers: {
  sessions: 'admin/sessions'
  }
  root :to => 'public/homes#top'
  devise_for :customers, controllers: {
  sessions: 'public/sessions',registrations: 'public/registrations'
  }
  
  namespace :admin do
  root :to => 'homes#top'
  resources :admins
  resources :products
  resources :customers
  resources :orders
  resources :genres
  end
  
  scope module: :public do
  get 'customers/quit' => 'customers#quit', as: 'customers_quit'
  get 'customers/show' => 'customers#show', as: 'customers_show'
  get 'customers/edit' => 'customers#edit', as: 'customers_edit'
  get 'customers/update' => 'customers#update', as: 'customers_update'
  resources :shipping_address
  resources :items
  resources :genres
  delete "cart_items/destroy_all", to: 'cart_items#destroy_all'
  resources :cart_items
  resources :orders
  resources :order_details
  patch 'customers/out' => 'customers#out', as: 'customers_out'
  get 'orders/log'
  get 'orders/thanx'
  get "about", as:'about', to:'homes#about'
  
  end
  
 
  #get "about" => 'public/homes#about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
