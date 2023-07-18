class CreatePostImageTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_image_tags do |t|
      t.integer :post_image_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
