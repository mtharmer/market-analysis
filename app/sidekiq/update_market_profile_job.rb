# frozen_string_literal: true

class UpdateMarketProfileJob
  # Set the Queue as Default
  include Sidekiq::Worker
  sidekiq_options retry: 0
  queue_as :default

  def perform(id)
    MarketProfileUpdater.new(id).call
  end
end
