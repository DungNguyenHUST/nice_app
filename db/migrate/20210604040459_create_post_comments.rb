class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.string :content
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
  end
end
