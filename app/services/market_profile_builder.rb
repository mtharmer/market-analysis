# frozen_string_literal: true

class MarketProfileBuilder
  def initialize(day, instrument_id)
    @day = day
    @instrument_id = instrument_id
  end

  def call
    return unless MarketProfile.find_by(day: @day, instrument_id: @instrument_id).nil?

    @bars = profile_bars
    unless @bars.present? && @bars.length > 2
      Rails.logger.error "Unable to find bars for #{@intrument_id} on day #{@day}"
      return
    end

    @profile = MarketProfile.create(initial_attributes)
    return unless @profile

    @profile.create_tpos
    @profile.calculate_value_area
    @profile.save!
  end

  def initial_attributes
    initial_balance = [@bars.first, @bars.second]
    {
      day: @day,
      instrument_id: @instrument_id,
      high: @bars.map(&:high).max,
      low: @bars.map(&:low).min,
      open: @bars.first.open,
      close: @bars.last.close,
      initial_balance_high: initial_balance.map(&:high).max,
      initial_balance_low: initial_balance.map(&:low).min
    }
  end

  private

  def profile_bars
    Bar.where(day: @day, instrument_id: @instrument_id)
       .where('time >= ? AND time < ?', '09:30', '16:00').order(:time)
  end
end
