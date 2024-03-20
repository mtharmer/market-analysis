# frozen_string_literal: true

class Instrument < ApplicationRecord
  has_many :bars, dependent: :destroy
  has_many :market_profiles, dependent: :destroy
end
