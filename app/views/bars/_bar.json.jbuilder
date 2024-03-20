# frozen_string_literal: true

json.extract! bar, :id, :day, :time, :instrument_id, :timeframe_measurement, :timeframe_value, :high, :low, :open,
              :close, :volume, :created_at, :updated_at
json.url bar_url(bar, format: :json)
