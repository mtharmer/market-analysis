class ConvertStringsToDateAndTime < ActiveRecord::Migration[7.0]
  def up
    change_column :bars, :day, 'date USING CAST(day AS date)'
    change_column :market_profiles, :day, 'date USING CAST(day AS date)'
  end

  def down
    change_column :bars, :day, 'varchar USING CAST(day AS varchar)'
    change_column :market_profiles, :day, 'varchar USING CAST(day AS varchar)'
  end
end
