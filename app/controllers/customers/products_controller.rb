class Customers::ProductsController < ApplicationController
  before_action :authenticate_customer!, only: [:show]

  def top
    @products = Product.all.order(created_at: :asc)
    @genres = Genre.all
  end

  def index
    @genres = Genre.all
    @products = Product.all.page(params[:page]).per(8)
  end

  def show
    @products = Product.all
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
