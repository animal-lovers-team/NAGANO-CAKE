class Customers::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @addresses = current_customer.addresses
    if @address.save
      flash[:notice] = "配送先を登録しました！"
      redirect_to customer_addresses_path
    else
      render :index
    end
  end
  
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送先情報を変更しました。"
      redirect_to customer_addresses_path
    else
      render :index
    end
  end
  
  

private

	def address_params
  	params.require(:address).permit(:postal_code, :address, :name)
  end


end