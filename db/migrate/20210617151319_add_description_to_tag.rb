class AddDescriptionToTag < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :description, :text
    add_column :tags, :avatar, :string
  end
end
