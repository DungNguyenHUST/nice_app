class CreatePostVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_votes do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :user_id

      t.timestamps
    end
  end
end
