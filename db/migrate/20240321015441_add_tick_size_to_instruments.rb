class AddTickSizeToInstruments < ActiveRecord::Migration[7.0]
  def change
    add_column :instruments, :tick_size, :decimal
  end
end
