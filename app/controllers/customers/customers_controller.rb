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
    @customer.update(is_deleted: true)
    reset_session
    flash[:alert] = "退会が完了しました"
    redirect_to root_path
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました！"
      redirect_to customers_path
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :street_address, :phone_number, :email)
  end

end
