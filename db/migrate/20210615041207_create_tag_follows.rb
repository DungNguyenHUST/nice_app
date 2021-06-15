class CreateTagFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_follows do |t|
		t.references :tag, null: false, foreign_key: true
		t.integer :user_id
		
		t.timestamps
    end
  end
end
