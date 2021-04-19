Rails.application.routes.draw do

  devise_for :customers,
    :controllers => {
      :registrations => "customers/registrations",
      :sessions => "customers/sessions",
      :passwords => "customers/passwords"
    }
  
  devise_for :admins,
    :controllers => {
      :sessions => "admin/sessions"
    }
  
  get 'about' => 'customers/products#about'
  root 'customers/products#top'
  get 'contact' => 'customers/customers#contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :customer, path: :customers do
    resources :products, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete "cart_items" => "cart_items#all_destroy", as: "cart_item_all_destroy"
    
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "confirm"
        get "complete"
      end
    end
    
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    get "my_page" => "customers#show", as: "customer"
    get "leave" => "customers#leave", as: "customer_leave"
    patch "out" => "customers#out", as: "customer_out"
    get "edit/my_page" => "customers#edit", as: "customer_edit"
    patch "update" => "customers#update", as: "customer_update"
  end
end

