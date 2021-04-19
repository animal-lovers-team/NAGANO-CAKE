class Customers::CartItemsController < ApplicationController
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
