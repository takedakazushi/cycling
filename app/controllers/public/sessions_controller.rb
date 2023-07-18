# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
   before_action :configure_sign_in_params, only: [:create]

     devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end

  def new_guest
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

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
