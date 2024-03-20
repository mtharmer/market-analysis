# frozen_string_literal: true

FactoryBot.define do
  factory :market_profile do
    day { 'MyString' }
    instrument
    high { '9.99' }
    low { '9.99' }
    open { '9.99' }
    close { '9.99' }
    initial_balance_high { '9.99' }
    initial_balance_low { '9.99' }
    value_area_high { '9.99' }
    value_area_low { '9.99' }
    point_of_control { '9.99' }
    day_type { 'MyString' }
    opening_type { 'MyString' }
  end
end
