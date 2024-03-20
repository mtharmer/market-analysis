# frozen_string_literal: true

FactoryBot.define do
  factory :instrument do
    symbol { 'ES' }
    exchange { 'CME' }
    asset_class { 'Futures' }
  end
end
