class Customers::OrdersController < ApplicationController
  include ApplicationHelper

  before_action :to_log, only: [:show]
  before_action :authenticate_customer!

  def new
  	@order = Order.new
  	@addresses = Address.where(customer: current_customer)
  end

	def log
    @cart_items = current_customer.cart_items
		@order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method]
    )
    @order.total_price = billing(@order)


    if params[:order][:addresses] == "residence"
      @order.postal_code = current_customer.postal_code
      @order.shipping_address     = current_customer.street_address
      @order.name        = current_customer.last_name +
                           current_customer.first_name

    elsif params[:order][:addresses] == "addresses"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.shipping_address     = address.address
      @order.name        = address.name

    # addressにnew_addressの値がはいっていれば
    elsif params[:order][:addresses] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.shipping_address     = params[:order][:shipping_address]
      @order.name        = params[:order][:name]
      @address = "1"

      # バリデーションがあるならエラーメッセージを表示
      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
	end

	def create
    @order = current_customer.orders.new(order_params)
    @order.save
    flash[:notice] = "ご注文が確定しました。"

    # もし情報入力でnew_addressの場合Addressに保存
    if current_customer.addresses.create(
      address: params[:order][:shipping_address],
      name: params[:order][:name],
      postal_code: params[:order][:postal_code]
      )
    end

    # カート商品の情報を注文商品に移動
    @cart_items = current_cart
    @cart_items.each do |cart_item|
    OrderDatail.create(
      product:  cart_item.product,
      order:    @order,
      quantity: cart_item.quantity,
      subprice: sub_price(cart_item)
    )
    end
    # 注文完了後、カート商品を空にする
    @cart_items.destroy_all
    redirect_to thanx_customers_orders_path
	end

	def thanx
	end

	def index
    @orders = current_customer.orders
	end

	def show
	  @order = Order.find(params[:id])
    @order_datails = @order.order_datails
	end

  private
  def order_params
    params.require(:order).permit(:postal_code,  :shipping_address, :name, :payment_method, :total_price)
  end

  def address_params
    params.require(:order).permit(:postal_code, :shipping_address, :name)
  end



  def to_log
    redirect_to customers_cart_items_path if params[:id] == "log"
  end

end