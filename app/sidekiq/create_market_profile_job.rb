# frozen_string_literal: true

class CreateMarketProfileJob
  # Set the Queue as Default
  include Sidekiq::Worker
  sidekiq_options retry: 0
  queue_as :default

  def perform(id, day)
    MarketProfileBuilder.new(day, id).call if Instrument.find(id)
  end
end
