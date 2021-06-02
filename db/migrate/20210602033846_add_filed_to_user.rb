class AddFiledToUser < ActiveRecord::Migration[6.1]
  def self.up
    change_table :users do |t|
      t.string :avatar
      t.string :phone
      t.string :address
      t.string :sign
      t.boolean :root, default: false
      t.boolean :admin, default: false
      t.boolean :user, default: true
    end
  end
end
