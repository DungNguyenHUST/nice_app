class CreateTopicReports < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_reports do |t|
      t.references :topic, null: false, foreign_key: true
      t.integer :user_id
      t.integer :report_type
      t.text :report_content

      t.timestamps
    end
  end
end
