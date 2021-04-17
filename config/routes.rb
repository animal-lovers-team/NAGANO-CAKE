Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers
  
   resources :customers, only: [:show, :index, :edit, :update, :destroy]
   #会員
   
end
