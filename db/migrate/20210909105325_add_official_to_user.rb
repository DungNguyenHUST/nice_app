class AddOfficialToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :official, :boolean, default: false
  end
end
