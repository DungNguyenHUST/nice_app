class AddPostCastToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :podcast, :string
  end
end
