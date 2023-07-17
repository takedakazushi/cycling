class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
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

  def favorited_by?(user)
    favorites.exists?(customer_id: customer.id)
  end
end
