class AddRateToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :rate, :float
  end
end
