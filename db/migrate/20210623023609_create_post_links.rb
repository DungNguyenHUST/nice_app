class CreatePostLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :post_links do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :user_id
      t.string :image
      t.string :favicon
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
