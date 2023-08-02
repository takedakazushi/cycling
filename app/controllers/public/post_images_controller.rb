class Public::PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end
   # 投稿データの保存
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.customer_id = current_customer.id
    if @post_image.save
    redirect_to post_images_path(@post_image), notice: "You have created book successfully."
    else
      @post_images = PostImage.all
      render 'new'
    end
  end
  def index
    @post_images = PostImage.all
    @customer = current_customer
    @post_image = PostImage.new
  end

  def show
    @post_images = PostImage.all
    @post_image = PostImage.find(params[:id])
    @newcycling = PostImage.new
    @post_comment = PostComment.new
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    @post_image.update(post_image_params)
    redirect_to post_image_path(@post_image.id)
  end
  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to post_images_path
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.customer_id = current_customer.id
    tags = Vision.get_image_data(post_image_params[:image])
    if @post_image.save
      tags.each do |tag|
      @post_image.tags.create(name: tag)
    end
    redirect_to post_image_path(@post_image.id)
    else
    render :new
    end
  end
  # 投稿データのストロングパラメータ
  private

  def post_image_params
    params.require(:post_image).permit(:couse_name, :image, :caption)
  end
end
