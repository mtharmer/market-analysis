class AddIndexesToBarsAndMarketProfiles < ActiveRecord::Migration[7.0]
  def up
    add_index :bars, %i[day time], unique: true, if_not_exists: true
    add_index :market_profiles, :day, unique: true, if_not_exists: true
  end

  def down
    remove_index :bars, %i[day time], if_exists: true
    remove_index :market_profiles, :day, if_exists: true
  end
end
