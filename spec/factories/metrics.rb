# frozen_string_literal: true

FactoryBot.define do
  factory :metric do
    market_profile { nil }
    avg_initial_balance { '9.99' }
    avg_true_range { '9.99' }
    initial_balance { '9.99' }
    true_range { '9.99' }
    z_score_initial_balance { '9.99' }
    z_score_true_range { '9.99' }
  end
end
