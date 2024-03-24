# frozen_string_literal: true

class GenerateMarketProfiles
  def call
    Instrument.includes(:bars).find_each do |instrument|
      days = instrument.bars.collect(&:day).uniq
      days.each do |day|
        CreateMarketProfileJob.perform_async(instrument.id, day) if weekday?(day)
      end
    end
  end

  def weekday?(day)
    [*1..6].include? Date.strptime(day, '%m/%d/%Y').wday
  end
end
