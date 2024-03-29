class AddManualTypesToMarketProfile < ActiveRecord::Migration[7.0]
  def change
    change_table :market_profiles, bulk: true do |t|
      t.string :manual_day_type
      t.string :manual_opening_type
    end
  end
end
