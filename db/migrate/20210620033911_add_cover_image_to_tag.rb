class AddCoverImageToTag < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :cover_image, :string
  end
end
