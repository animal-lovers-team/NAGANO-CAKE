class Customers::ProductsController < ApplicationController
  before_action :authenticate_customer!, only: [:show]
  
  def top
    @products = Product.all.order(created_at: :asc)
    @genres = Genre.all
  end
  
  def index
    @products = Product.all.page(params[:page])
  end
  
  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def about
  end
  
  
  private
  
  def product_params
    params.require(:product).permit(:name, :price, :introduction, :image_id, :is_active, :genre_id)
  end
  
end
