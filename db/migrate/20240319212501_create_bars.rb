class CreateBars < ActiveRecord::Migration[7.0]
  def change
    create_table :bars do |t|
      t.string :day
      t.string :time
      t.references :instrument, null: false, foreign_key: true
      t.string :timeframe_measurement
      t.integer :timeframe_value
      t.decimal :high
      t.decimal :low
      t.decimal :open
      t.decimal :close
      t.integer :volume

      t.timestamps
    end
  end
end
