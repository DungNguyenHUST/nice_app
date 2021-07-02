class AddCategoryToTopic < ActiveRecord::Migration[6.1]
  def change
    add_reference :topics, :category, null: false, foreign_key: true
  end
end
