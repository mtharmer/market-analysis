class CreateTpos < ActiveRecord::Migration[7.0]
  def change
    create_table :tpos do |t|
      t.references :market_profile, null: false, foreign_key: true
      t.decimal :price
      t.text :letters, array: true, default: []

      t.timestamps
    end
  end
end
