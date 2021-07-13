class DropUnvoteTable < ActiveRecord::Migration[6.1]
  def change
    if table_exists? :post_unvotes
      drop_table :post_unvotes
    end

    if table_exists? :post_comment_unvotes
      drop_table :post_comment_unvotes
    end
  end
end
