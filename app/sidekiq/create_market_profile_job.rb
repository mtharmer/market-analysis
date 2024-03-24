# frozen_string_literal: true

class CreateMarketProfileJob
  # Set the Queue as Default
  include Sidekiq::Worker
  sidekiq_options retry: 0
  queue_as :default

  def perform(id, day)
    Rails.logger.info "Received with id #{id}, class #{id.class}, day #{day}, class #{day.class}"
    return unless id.is_a?(Integer) && day.is_a?(String)

    return if Instrument.find_by(id: id).nil?

    MarketProfileBuilder.new(day, id).call
  end
end
