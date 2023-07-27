class Admin::PostImagesController < ApplicationController
  def edit
    @post_image = PostImage.find(params[:id])
  end
  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to admin_customer_path(params[:customer_id])
  end
end