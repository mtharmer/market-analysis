# frozen_string_literal: true

class MarketProfileUpdater
  def initialize(id)
    @id = id
  end

  def call
    @profile = MarketProfile.find(@id)
    return unless @profile.exists?

    @profile.set_metrics
    @profile.day_type = day_finder
    @profile.opening_type = opening_type_finder
    @profile.save!
  end
end
