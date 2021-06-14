class CreatePostCommentUnvotes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comment_unvotes do |t|
		t.references :post_comment, null: false, foreign_key: true
		t.integer :user_id

		t.timestamps
    end
  end
end
