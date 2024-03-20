# frozen_string_literal: true

FactoryBot.define do
  factory :instrument do
    symbol { 'MyString' }
    exchange { 'MyString' }
    asset_class { 'MyString' }
  end
end
