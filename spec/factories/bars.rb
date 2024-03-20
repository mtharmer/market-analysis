# frozen_string_literal: true

FactoryBot.define do
  factory :bar do
    day { 'MyString' }
    time { 'MyString' }
    instrument { nil }
    timeframe_measurement { 'MyString' }
    timeframe_value { 1 }
    high { '9.99' }
    low { '9.99' }
    open { '9.99' }
    close { '9.99' }
    volume { 1 }
  end
end
