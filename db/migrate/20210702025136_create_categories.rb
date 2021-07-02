class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :user_id

      t.timestamps
    end
    add_column :categories, :slug, :string
    add_index :categories, :slug, unique: true
  end
end
