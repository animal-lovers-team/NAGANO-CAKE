class Customers::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :edit, :update, :leave, :out]
  before_action :rule_path, only: [:rule]

  def show
    @customer = current_customer
  end
  
  def leave
    @custmoer = current_customer
  end
  
  def out
    @customer = current_customer
    @custmoer.update(is_deleted: true)
    reset_section
    flash[:alert] = "退会が完了しました"
    redirect_to top_path
  end
  
  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      falsh[:notice] = "会員情報を更新しました！"
      redirect_to customer_customer_path
    else
      render :edit
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number)
  end
  
end
