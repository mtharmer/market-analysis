# frozen_string_literal: true

class RecalculateMarketProfiles
  MarketProfile.order(:date).map(&:id).each do |profile_id|
    UpdateMarketProfileJob.perform_async(profile_id)
  end
end
