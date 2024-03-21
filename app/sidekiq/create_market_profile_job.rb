# frozen_string_literal: true

class CreateMarketProfileJob
  # Set the Queue as Default
  include Sidekiq::Worker
  queue_as :default

  def perform(id, day)
    instrument = Instrument.find_by(id: id)
    MarketProfileBuilder.new(day, instrument).call if instrument.present?
  end
end
