class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.text :caption
      t.string :couse_name
      t.integer	:customer_id
      t.timestamps
    end
  end
end
