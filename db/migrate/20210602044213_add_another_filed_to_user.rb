class AddAnotherFiledToUser < ActiveRecord::Migration[6.1]
  def self.up
    change_table :users do |t|
      t.string :name
      t.string :education
      t.string :job
      t.string :facebook_site
      t.string :site
      t.datetime :birth_day
    end
  end
end
