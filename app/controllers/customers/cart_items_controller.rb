class Customers::CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:updete, :destroy]
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
    @cart_items.each do |cart_item|
      @subtotal = (Product.find(cart_item.product_id).price * cart_item.quantity).to_i
      @total_price += @subtotal
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(quantity: params[:cart_item][:quantity].to_i)
    flash[:notice] = "#{@cart_item.item.name}の数量を変更しました。"
    redirect_to customers_cart_items_path
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_items_params)
    @update_cart_item =  CartItem.find_by(product: @cart_item.product)
    if @update_cart_item.present? && @cart_item.valid?
      @cart_item.quantity += @update_cart_item.quantity
      @update_cart_item.destroy
    end
    if @cart_item.save
     flash[:notice] = "#{@cart_item.product.name}をカートに追加しました"
      redirect_to customers_cart_items_path
    else
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      flash[:alert] = "個数を選択してください。"
      render "customers/products/show"
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:alert] = "#{@cart_item.item.name}を削除しました。"
    redirect_to customesr_cart_items_path
  end

  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:alert] = "カートの商品を全て削除しました。"
    redirect_to customers_cart_items_path
  end

  private

  def cart_items_params
    params.require(:cart_item).permit(:quantity, :product_id)
  end

  def baria_user
    unless CartItem.find(params[:id]).customer.id.to_i == current_customer.id
      redirect_to customer_customer_path
    end
  end
end