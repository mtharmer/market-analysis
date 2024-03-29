class CreateMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :metrics do |t|
      t.references :market_profile, null: false, foreign_key: true
      t.decimal :avg_initial_balance, precision: 10, scale: 2
      t.decimal :avg_true_range, precision: 10, scale: 2
      t.decimal :initial_balance, precision: 10, scale: 2
      t.decimal :true_range, precision: 10, scale: 2
      t.decimal :z_score_initial_balance, precision: 10, scale: 2
      t.decimal :z_score_true_range, precision: 10, scale: 2

      t.timestamps
    end
  end
end
