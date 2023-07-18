class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :full_name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit:[width, height]).processed
  end

  #def name
  #  self.last_name + self.first_name
  #end

  def self.search_for(content, method)
    if method == 'perfect'
      Customer.where(full_name: content)
    elsif method == 'forward'
      Customer.where('full_name LIKE ?', content + '%')
    elsif method == 'backward'
      Customer.where('full_name LIKE ?', '%' + content)
    else
      Customer.where('full_name LIKE ?', '%' + content + '%')
    end
  end
end
