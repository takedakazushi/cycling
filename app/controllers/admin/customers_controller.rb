class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @post_image = PostImage.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer =  Customer.find(params[:id])
    @post_images = @customer.post_images
  end
end
