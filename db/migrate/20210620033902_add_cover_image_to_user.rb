class AddCoverImageToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cover_image, :string
  end
end
