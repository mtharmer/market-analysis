class AddTotalTposToMarketProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :market_profiles, :total_tpos, :integer
  end
end
