class Admin::PostImagesController < ApplicationController
  def edit
    @post_image = PostImage.find(params[:id])
  end
end