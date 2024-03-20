class Bar < ApplicationRecord
  require 'csv'

  belongs_to :instrument

  self.per_page = 50

  def self.import(file, instrument)
    CSV.foreach(file.path, headers: true) do |row|
      row = row.to_h
      timestamp = row['timestamp'].to_datetime
      day = datetime_to_day(timestamp)
      time = datetime_to_time(timestamp)
      Bar.create_with(open: row['open'], close: row['close'], high: row['high'], low: row['low'], volume: row['volume'])
         .find_or_create_by(instrument_id: instrument.id, day: day, time: time)
    end
  end

  def self.datetime_to_day(datetime)
    datetime.strftime '%m/%d/%Y'
  end

  def self.datetime_to_time(datetime)
    datetime.strftime '%H:%M'
  end
end
