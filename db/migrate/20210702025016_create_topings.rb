class CreateTopings < ActiveRecord::Migration[6.1]
  def change
    create_table :topings do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
