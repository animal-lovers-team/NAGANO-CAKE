class Customers::CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:updete, :destroy]
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer.cart_items
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(quantity: params[:cart_item][:quantity].to_i)
    flash[:notice] = "#{@cart_item.item.name}の数量を変更しました。"
    redirect_to customer_cart_items_path
  end
  
  def create
    @cart_item = current_customer.cart_items.new(params_cart_item)
    @update_cart_item = CartItem.find_by(item: @cart_item.item)
    if @update_cart_item.present? && @cart_item.valid?
      @cart_item.quantity += @update_cart_item.quantity
      @update_cart_item.destroy
    end
    
    if @cart_item.save
      flash[:notice] = "#{@cart_item.product.name}を追加しました"
      redirect_to products_path
    else
      @product = Product.find(params[:cart_item][:product_id])
      @cart_item = CartItem.new
      flash[:alert] = "個数を選んでください"
      render ("customer/products/show")
    end
  end
  
  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:alert] = "カートの商品を全て削除しました"
    redirect_to customers_cart_items_path
  end
  
  def destroy
    @cart_item.destroy
    flash.now[:alert] = "#{@cart_item.product.name}を削除しました。"
    @cart_items = current＿cart
    @total = total_price(@cart_items).to_s(delimited)
  end
    
  private
  
  def params_cart_item
    params.require(:cart_item).permit(:quantity, :product_id)
  end

end
