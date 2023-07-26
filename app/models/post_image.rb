class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :couse_name,presence:true
  validates :caption,presence:true
  validates :image, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit:[width, height]).processed
  end

  def favorited_by?(target_customer)
    favorites.where(customer_id: target_customer.id).exists?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      PostImage.where(caption: content)
    elsif method == 'forward'
      PostImage.where('caption LIKE ?', content+'%')
    elsif method == 'backward'
      PostImage.where('caption LIKE ?', '%'+content)
    else
      PostImage.where('caption LIKE ?', '%'+content+'%')
    end
  end

end
