# frozen_string_literal: true

class GenerateMarketProfiles
  def call
    Instrument.includes(:bars).find_each do |instrument|
      days = instrument.bars.collect(&:day).uniq
      days.each do |day|
        args = { id: instrument.id, day: day }.to_json
        id = instrument.to_h['id']
        CreateMarketProfileJob.perform_later(id, day)
      end
    end
  end
end
