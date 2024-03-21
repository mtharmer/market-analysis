# frozen_string_literal: true

class MarketProfile < ApplicationRecord
  belongs_to :instrument
  has_many :tpos, dependent: :destroy
end
