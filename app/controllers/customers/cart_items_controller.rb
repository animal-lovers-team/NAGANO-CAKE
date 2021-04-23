class Customers::CartItemsController < ApplicationController

  before_action :authenticate_customer!
  before_action :baria_user, only: [:update, :destroy]


  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(quantity: params[:cart_item][:quantity].to_i)
    flash[:notice] = "#{@cart_item.product.name}の数量を変更しました。"
    redirect_to customers_cart_items_path
  end

  def create
    @cart_item = current_customer.cart_items.new(params_cart_item)
    @update_cart_item = CartItem.find_by(product: @cart_item.product)
    if @update_cart_item.present? && @cart_item.valid?
      @cart_item.quantity += @update_cart_item.quantity
      @update_cart_item.destroy
    end
    if  @cart_item.save
      flash[:notice] = "#{@cart_item.product.name}をカートに追加しました。"
      redirect_to customers_cart_items_path
    else
      @product = Product.find(params[:cart_item][:product_id])
      @cart_item = CartItem.new
<<<<<<< HEAD
      flash[:notice] = "個数を選択してください。"
=======
<<<<<<< HEAD
      #flash[:alert] = "個数を選択してください。"
      flash[:notice] = "個数を選択してください。"
=======
<<<<<<< HEAD
      flash[:alert] = "個数を選択してください。"
=======
      flash[:notice] = "個数を選択してください。"
>>>>>>> de594743f6143aecbd95d92ee11abd00e2f014df
>>>>>>> f5214f7d0dbc69cb50ccb39802e1802e05a35eaa
>>>>>>> 1f822cfbb139f2c1c305021a15fafa7c92593250
      render "customers/products/show"
    end
  end

  def index
    @cart_items = current_customer.cart_items
    @sum = 0
    @cart_items.each do |cart_item|
      @total = (Product.find(cart_item.product_id).price * 1.1 * cart_item.quantity).to_i
      @sum += @total
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:alert] = "#{@cart_item.product.name}を削除しました。"
    redirect_to customers_cart_items_path
  end

  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    flash[:alert] = "カートの商品を全て削除しました。"
    redirect_to customers_cart_items_path
  end

  private

  def params_cart_item
    params.require(:cart_item).permit(:quantity, :product_id)
  end

  def baria_user
    unless CartItem.find(params[:id]).customer.id.to_i == current_customer.id
      redirect_to customers_customer_path
    end
  end
<<<<<<< HEAD

end
=======
end
>>>>>>> f5214f7d0dbc69cb50ccb39802e1802e05a35eaa
