class Tag < ApplicationRecord
  has_many :post_image_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :post_images, through: :post_image_tags
  
  scope :merge_post_images, -> (tags){ }
  
  def self.search_post_images_for(content, method)
    
    if method == 'perfect'
      tags = Tag.where(full_name: content)
    elsif method == 'forward'
      tags = Tag.where('full_name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('full_name LIKE ?', '%' + content)
    else
      tags = Tag.where('full_name LIKE ?', '%' + content + '%')
    end
    
    return tags.inject(init = []) {|result, tag| result + tag.post_images}
  end
end