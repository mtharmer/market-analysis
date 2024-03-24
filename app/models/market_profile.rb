# frozen_string_literal: true

class MarketProfile < ApplicationRecord
  belongs_to :instrument
  has_many :tpos, dependent: :destroy

  delegate :tick_size, to: :instrument

  def create_tpos
    return unless tpo_hash.any?

    tpo_hash.each do |key, val|
      Tpo.create(market_profile_id: id, price: key, letters: val)
    end

    self.point_of_control = highest_tpo&.price
    self.total_tpos = related_tpos.map { _1.letters.length }.inject(&:+)
  end

  def calculate_value_area
    vah = val = point_of_control
    current_sum = tpo_point_of_control_length
    total_sum = (total_tpos * 0.7).to_i

    self.value_area_high, self.value_area_low = search_for_value_limits(current_sum, total_sum, vah, val)
  end

  private

  def tpo_point_of_control_length
    related_tpos.find_by(price: point_of_control)&.letters&.length || 0
  end

  def highest_tpo
    related_tpos.order(Arel.sql('array_length(letters, 1) DESC, price DESC')).first
  end

  def tpo_hash
    tick_size = instrument.tick_size
    tpos = {}
    profile_bars.each_with_index do |bar, idx|
      # Iterate over all all price points hit in the bar
      i = bar.low
      letter = (65 + idx).chr
      while i < bar.high
        if tpos[i].nil?
          tpos[i] = [letter]
        else
          tpos[i].push letter
        end
        i += tick_size
      end
    end
    tpos
  end

  def search_for_value_limits(current_sum, total_sum, vah, val)
    while current_sum < total_sum
      higher = tpo_letters(vah + tick_size)
      lower = tpo_letters(val - tick_size)
      vah, val, current_sum = higher_or_lower(higher, lower, vah, val, current_sum)
    end

    [vah, val]
  end

  def higher_or_lower(higher, lower, vah, val, sum)
    if higher > lower
      vah += tick_size
      sum += higher
    elsif higher <= lower
      val -= tick_size
      sum += lower
    end

    [vah, val, sum]
  end

  def related_tpos
    Tpo.where(market_profile_id: id)
  end

  def tpo_letters(price)
    related_tpos.find { _1.price == price }&.letters&.length || 0
  end

  def profile_bars
    instrument.bars.where(day: day)
              .where('time >= ? AND time < ?', '09:30', '16:00').order(:time).to_a
  end
end
