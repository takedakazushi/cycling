class Public::HomesController < ApplicationController
  def top
  end

  def new_guest
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.full_name = "guest_customer"
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = "guest_customer"
      customer.first_name = "guest_customer"
      customer.last_name_kana = "guest_customer"
      customer.first_name_kana = "guest_customer"
      customer.post_code = "guest_customer"
      customer.address = "guest_customer"
      customer.phone_number = "guest_customer"
      customer.is_deleted =false
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。マイページを押してください'
  end

end