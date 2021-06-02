class AddAnotherColToUser < ActiveRecord::Migration[6.1]
  def self.up
    change_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :token
    end
  end
end
