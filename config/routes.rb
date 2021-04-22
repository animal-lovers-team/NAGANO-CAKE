Rails.application.routes.draw do

  devise_for :admins
  namespace :admin do
    resources :customers,only: [:index,:show,:edit,:update]
  	resources :products,only: [:index,:new,:create,:show,:edit,:update,]
  	get 'top'=>'products#top'
  	resources :genres,only: [:index,:create,:edit,:update, :show]
  	resources :orders,only: [:index,:show,:update] do
  	  member do
        get :current_index
        resource :order_details,only: [:update]
      end
      collection do
        get :today_order_index
      end
    end
  end

  devise_for :customers,:controllers => {
      :sessions => "customers/sessions",
      :registrations => "customers/registrations",
      :passwords => "customers/passwords"
    }

  get 'about' => 'customers/products#about'
  root 'customers/products#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :customers do
    resources :products,only: [:index,:show]
    get 'customer/edit' => 'customers#edit'
    put 'customer' => 'customers#update'

  	resource :customers,only: [:show] do
  		collection do
  	     get 'leave'
  	     patch 'out'
  	  end


      resources :cart_items,only: [:index,:update,:create,:destroy] do
        collection do
          delete '/' => 'cart_items#all_destroy'
        end
      end



      resources :orders,only: [:new,:index,:show,:create] do
        collection do
          post 'log'
          get 'thanx'
        end
      end

      resources :addresses,only: [:index,:create,:edit,:update,:destroy]
    end
  end
end
