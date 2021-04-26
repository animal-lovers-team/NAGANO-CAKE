class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
  		@order_datail = OrderDetail.find(params[:id])
		  if @order_datail.update(order_datail_params)
		  	flash[:success] = "制作ステータスを変更しました"
		    redirect_to admin_order_path(@order_datail.order)
		  else
		     render "show"
		  end
  end

  private
  def order_datail_params
		  params.require(:order_datail).permit(:produciton_status)
	end

end