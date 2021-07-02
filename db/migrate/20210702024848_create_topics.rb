class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.string :avatar
      t.string :cover_image
      t.integer :user_id

      t.timestamps
    end
    add_column :topics, :slug, :string
    add_index :topics, :slug, unique: true
  end
end
