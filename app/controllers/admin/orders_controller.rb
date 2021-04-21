class OrdersController < ApplicationController

  before_action :authenticate_admin!

  def top
    from = Time.current.beginning_of_day
    to = Time.current.end_of_day
    @orders = Order.where(created_at: from..to)
  end

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @product_orders = @order.product_orders.all
    # 下記３行は商品合計を出すため
    @sum = 0
    @subtotals = @product_orders.map { |product_order| product_order.once_price * product_order.quantity }
    @sum = @subtotals.sum
  end

  def order_status_update
    @order = Order.find(params[:order][:id])
    if @order.update(params_int(order_params))
      flash[:success] = "注文ステータスを更新しました"
      order_status_is_deposited?(@order)
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "注文ステータスの更新に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def product_orders_status_update
    @product_order = ProductOrder.find(params[:product_order][:id])
    if @product_order.update(params_int(product_order_params))
      flash[:info] = "製作ステータスを更新しました"
      product_order_status_is_in_production?(@product_order)
      @order = Order.find_by(id: params[:product_order][:order_id])
      product_order_status_is_production_complete?(@order)
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "製作ステータスの更新に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

  def product_order_params
    params.require(:product_order).permit(:product_order_status, :id)
  end

  # 以下２つは、update時formから送られてくる値がデフォルトでstringなのでintegerに変換するためのもの。まずはそもそも整数にできるか調べる（Integer()で変換できれば数値、例外発生したら違う）
  def integer_string?(str)
    Integer(str)
    true
  rescue ArgumentError
    false
  end

  def params_int(order_params)
    order_params.each do |key, value|
      if integer_string?(value)
        order_params[key] = value.to_i
      end
    end
  end

  # 注文ステータスが「入金確認」になったら紐づく製作ステータス全てを「製作待ち」に自動更新
  def order_status_is_deposited?(order)
    if order.order_status_before_type_cast == 1
      order.product_orders.each do |p|
        p.update(product_order_status: 1)
      end
      flash[:info] = "製作ステータスが「製作待ち」に更新されました"
    end
  end

  # 製作ステータスが全部「製作完了」になったら注文ステータスが「発送準備中」に自動更新
  def product_order_status_is_production_complete?(order)
    if  order.product_orders.all? do |p|
          p.product_order_status_before_type_cast == 3
        end
      order.update(order_status: 3)
      flash[:success] = "注文ステータスが「発送準備中」に更新されました"
    end
  end

  # 製作ステータスが一つでも「製作中」になったら注文ステータスが「製作中」に自動更新
  def product_order_status_is_in_production?(product_order)
    if product_order.product_order_status_before_type_cast == 2
      product_order.order.update(order_status: 2)
      flash[:success] = "注文ステータスが「製作中」に更新されました"
    end
  end

end