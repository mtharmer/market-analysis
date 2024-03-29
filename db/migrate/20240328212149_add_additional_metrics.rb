class AddAdditionalMetrics < ActiveRecord::Migration[7.0]
  def change
    change_table :metrics, bulk: true do |t|
      t.boolean :broken_high, default: false, null: false
      t.boolean :broken_low, default: false, null: false
      t.boolean :close_within_range, default: false, null: false
      t.boolean :close_near_extreme, default: false, null: false
    end
  end
end
