class AddNotiToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :noti_when_comment, :boolean, default: true
    add_column :users, :noti_when_message, :boolean, default: true
    add_column :users, :noti_when_tagging, :boolean, default: true
    add_column :users, :noti_when_follow, :boolean, default: true
    add_column :users, :noti_when_vote, :boolean, default: false
    add_column :users, :noti_when_unvote, :boolean, default: false
    add_column :users, :noti_when_report, :boolean, default: true
    add_column :users, :noti_weekly, :boolean, default: true
  end
end
