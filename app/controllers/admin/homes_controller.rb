class Admin::HomesController < ApplicationController
   before_action :authenticate_admin!

  def top
       @customers = Customer.all
       @post_images = PostImage.all
  end

end
