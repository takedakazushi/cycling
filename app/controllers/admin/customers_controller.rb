class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @post_image = PostImage.all
  end
end
