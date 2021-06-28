class AddShareToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :post_shared_id, :integer
  end
end
