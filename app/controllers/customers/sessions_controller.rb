# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user, only: [:create]
  
  private
  
  def reject_inactive_user
    @customer = Custmer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.vaild_password?(params[customer][:password]) && @customer.is_deleted
        flash[:alert] = "退会済みのアカウントのため、ご利用出来ません。"
        redirect_to new_custmer_session_path
      end
    end
  end  
  
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
