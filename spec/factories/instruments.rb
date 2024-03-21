# frozen_string_literal: true

FactoryBot.define do
  factory :instrument do
    symbol { 'ES' }
    tick_size { 0.25 }
    exchange { 'CME' }
    asset_class { 'Futures' }
  end
end
