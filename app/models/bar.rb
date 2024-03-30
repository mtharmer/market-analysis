# frozen_string_literal: true

class Bar < ApplicationRecord
  require 'csv'

  belongs_to :instrument

  self.per_page = 50

  def self.import(file, instrument) # rubocop:disable Metrics/AbcSize
    CSV.foreach(file.path, headers: true) do |row|
      row = row.to_h
      dateargs = row['timestamp'].split
      unless dateargs.length == 2
        Rails.logger.error "Length is not 2 - #{ts}"
        next
      end
      day = dateargs[0]
      time = dateargs[1]
      Bar.create_with(open: row['open'], close: row['close'], high: row['high'], low: row['low'], volume: row['volume'])
         .find_or_create_by(instrument_id: instrument.id, day: day, time: time)
    end
  end
end
