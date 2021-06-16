class CreatePostFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :post_follows do |t|

      t.timestamps
    end
  end
end
