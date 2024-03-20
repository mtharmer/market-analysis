class CreateMarketProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :market_profiles do |t|
      t.string :day
      t.references :instrument, null: false, foreign_key: true
      t.decimal :high
      t.decimal :low
      t.decimal :open
      t.decimal :close
      t.decimal :initial_balance_high
      t.decimal :initial_balance_low
      t.decimal :value_area_high
      t.decimal :value_area_low
      t.decimal :point_of_control
      t.string :day_type
      t.string :opening_type

      t.timestamps
    end
  end
end
