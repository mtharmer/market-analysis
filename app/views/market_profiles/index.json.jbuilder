# frozen_string_literal: true

json.array! @market_profiles, partial: 'market_profiles/market_profile', as: :market_profile
