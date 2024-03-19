class CreateInstruments < ActiveRecord::Migration[7.0]
  def change
    create_table :instruments do |t|
      t.string :symbol
      t.string :exchange
      t.string :asset_class

      t.timestamps
    end
  end
end
