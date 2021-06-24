class AddFieldToUserNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :user_notifications, :original_url, :string
    add_column :user_notifications, :trigger_user_id, :integer
    add_column :user_notifications, :readed, :boolean, default: false
    add_column :user_notifications, :noti_type, :string
  end
end
