class CreatePostCommentReports < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comment_reports do |t|
      t.references :post_comment, null: false, foreign_key: true
      t.integer :user_id
      t.integer :report_type
      t.text :report_content

      t.timestamps
    end
  end
end
