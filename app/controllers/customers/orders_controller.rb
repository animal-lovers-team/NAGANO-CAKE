class Customers::OrdersController < ApplicationController

  include ApplicationHelper

  before_action :to_confirm, only: [:show]
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new

    @order.totai_price = billing(@order)

     if params[:order][:addresses] == "residence"
      @order.postal_code = current_customer.postal_tcode
      @order.shipping_address = current_customer.street_address
      @order.name = current_customer.last_name + current_customer.first_name
     elsif params[:order][:addresses] == "registration"
      delivery = Address.find(params[:order][:Address_id])
      @order.postal_code = delivery.postal_code
      @order.shipping_address = delivery.address
      @order.name = delivery.name
     elsif params[:order][:addresses] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.shipping_address = params[:order][:shipping_address]
      @order.name = params[:order][:name]
      @delivery = "1"
     end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    flash[:notice] = "ご注文が確定しました。"
    redirect_to complete_customer_orders_path

    if params[:order][:delivery] == "1"
      current_customer.deliver_destinations.create(address_params)
    end

    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
    ItemOrder.create(
      item: cart_item.item,
      order: @order,
      quantity: cart_item.quantity,
      tax_price: tax_price(cart_item.item.price)
      )
    end

     @cart_items.destroy_all
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @item_orders = @order.item_orders
  end

  private
  def order_params
    params.require(:order).permit(:total_price, :payment_method, :postal_code, :shipping_address, :name)
  end

  def address_params
    params.require(:order).permit(:postal_code, :shipping_address, :name)
  end

  def to_confirm
    redirect_to customer_items_path if params[:id] == "confirm"
  end

end
