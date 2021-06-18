class AddSettingFiledToUser < ActiveRecord::Migration[6.1]
  def self.up
    change_table :users do |t|
      t.string :company
	  t.string :school
	  t.text :introduce
    end
  end
end
