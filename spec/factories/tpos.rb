# frozen_string_literal: true

FactoryBot.define do
  factory :tpo do
    market_profile
    price { '9.99' }
    letters { 'MyText' }
  end
end
