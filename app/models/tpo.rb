# frozen_string_literal: true

class Tpo < ApplicationRecord
  belongs_to :market_profile

  def letters_for_display
    letters&.join(' ')
  end

  def in_initial_balance?
    letters.include?('A') || letters.include?('B')
  end

  def poc?
    price == market_profile.point_of_control
  end

  def in_value_area?
    price >= market_profile.value_area_low && price <= market_profile.value_area_high
  end
end
