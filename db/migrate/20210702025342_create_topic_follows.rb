class CreateTopicFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_follows do |t|
      t.references :topic, null: false, foreign_key: true
		  t.integer :user_id

      t.timestamps
    end
  end
end
