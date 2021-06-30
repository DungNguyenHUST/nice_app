class AddShareCountToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :share_count, :integer, :default => 0
  end
end
