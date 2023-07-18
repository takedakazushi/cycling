class Public::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @post_image = PostImage.new
  end

  def show
    @customer = Customer.find(params[:id])
    @post_images = @customer.post_images
    @newcycling = PostImage.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
    else
    render :edit
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
   end
  end

  private
  def customer_params
    params.require(:customer).permit(:full_name, :profile_image, :introduction)
  end


end