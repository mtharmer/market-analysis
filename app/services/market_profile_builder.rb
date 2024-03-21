# frozen_string_literal: true

class MarketProfileBuilder
  def initialize(day, instrument)
    @day = day
    @instrument = instrument
  end

  def call
    raise ActiveRecord::RecordNotUnique if MarketProfile.find_by(day: @day, instrument: @instrument)

    @bars = find_profile_bars
    create_profile
  end

  def initial_attributes
    {
      day: @day,
      instrument: @instrument,
      high: @bars.map(&:high).max,
      low: @bars.map(&:low).min,
      open: @bars.first.open,
      close: @bars.last.close,
      initial_balance_high: [@bars.first, @bars.second].map(&:high).max,
      initial_balance_low: [@bars.first, @bars.second].map(&:high).min
    }
  end

  def create_profile
    @profile = MarketProfile.create(initial_attributes)
    create_tpos
  end

  def create_tpos
    tpo_hash.each do |key, val|
      Tpo.create(market_profile: @profile, price: key.to_f, letters: val)
    end
    @profile.reload
    calculate_additional_data
  end

  def calculate_additional_data
    tpos = Tpo.where(market_profile: @profile)
    poc_tpo = tpos.order(Arel.sql('array_length(letters, 1) DESC')).first
    @profile.update(
      total_tpos: tpos.map { _1.letters.length }.inject(&:+),
      point_of_control: poc_tpo.price
    )
    calculate_value_area(tpos.to_a, poc_tpo)
  end

  def calculate_value_area(tpos, poc_tpo)
    vah = val = poc_tpo.price
    sum = poc_tpo.letters.length
    while sum < (@profile.total_tpos * 0.7).to_i
      higher = tpos.find { _1.price == (vah + @instrument.tick_size) }
      lower = tpos.find { _1.price == (val - @instrument.tick_size) }
      if !lower || higher.letters.length > lower.letters.length
        vah += @instrument.tick_size
        sum += higher.letters.length
      elsif !higher || higher.letters.length <= lower.letters.length
        val -= @instrument.tick_size
        sum += lower.letters.length
      end
    end
    @profile.update(
      value_area_high: vah,
      value_area_low: val
    )
  end

  def tpo_hash
    tpos = {}
    @bars.each_with_index do |bar, idx|
      # Iterate over all all price points hit in the bar
      i = bar.low
      letter = (65 + idx).chr
      while i < bar.high
        if tpos[i].nil?
          tpos[i] = [letter]
        else
          tpos[i].push letter
        end
        i += @instrument.tick_size
      end
    end
    tpos
  end

  private

  def find_profile_bars
    Bar.where(day: @day, instrument: @instrument)
       .where('time >= ? AND time < ?', '09:30', '16:00').order(:time).to_a
  end
end
