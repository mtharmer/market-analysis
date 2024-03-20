# frozen_string_literal: true

json.extract! market_profile, :id, :day, :instrument_id, :high, :low, :open, :close, :initial_balance_high,
              :initial_balance_low, :value_area_high, :value_area_low, :point_of_control, :day_type, :opening_type,
              :created_at, :updated_at
json.url market_profile_url(market_profile, format: :json)
