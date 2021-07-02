class DropTag < ActiveRecord::Migration[6.1]
  def change
    drop_table :tags, force: :cascade
    drop_table :taggings, force: :cascade
    drop_table :tag_follows, force: :cascade
  end
end
