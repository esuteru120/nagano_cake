Rails.application.routes.draw do
  devise_for :admin, controllers: {
  sessions: 'admin/sessions'
  }
  root :to => 'public/homes#top'
  
 
  
  namespace :admin do
  root :to => 'homes#top'
  resources :admins
  resources :products
  resources :customers
  resources :orders
  resources :genres
  end
  
  scope module: :public do
  resource :customers, only:[:show,:edit,:update] do 
    collection do 
      get 'quit'
      patch 'out'
    end
  end 
  resources :shipping_address
  resources :items
  resources :genres
  delete "cart_items/destroy_all", to: 'cart_items#destroy_all'
  resources :cart_items
  post 'orders/log'
  get 'orders/thanx'
  resources :orders
  resources :order_details
  get "about", as:'about', to:'homes#about'
  
  end
   devise_for :customers, controllers: {
  sessions: 'public/sessions', registrations: 'public/registrations', passwords: 'public/passwords'
  }
  #get "about" => 'public/homes#about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end