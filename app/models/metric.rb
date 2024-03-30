# frozen_string_literal: true

class Metric < ApplicationRecord
  belongs_to :market_profile

  include MetricConcern

  delegate :high, :low, :close,
           :initial_balance_high, :initial_balance_low,
           :ib_high_variance, :ib_low_variance,
           :tr_high_variance, :tr_low_variance,
           :instrument,
           to: :market_profile

  def set_metrics
    self.initial_balance = find_initial_balance
    self.true_range = find_true_range
    self.avg_initial_balance = find_average_initial_balance
    self.avg_true_range = find_average_true_range
    self.z_score_initial_balance = find_z_score_ib
    self.z_score_true_range = find_z_score_tr
    find_broken
    find_close
    save!
  end

  def find_initial_balance
    market_profile.initial_balance_high - market_profile.initial_balance_low
  end

  def find_true_range
    market_profile.high - market_profile.low
  end

  def find_average_initial_balance
    mean(six_month_profiles.map(&:initial_balance))
  end

  def find_average_true_range
    mean(six_month_profiles.map(&:true_range))
  end

  def find_z_score_ib
    z_score(initial_balance, six_month_profiles.map(&:initial_balance))
  end

  def find_z_score_tr
    z_score(initial_balance, six_month_profiles.map(&:true_range))
  end

  def find_broken
    self.broken_high = high > ib_high_variance
    self.broken_low = low < ib_low_variance
  end

  def find_close
    self.close_within_range = (close <= ib_high_variance && close >= ib_low_variance)
    self.close_near_extreme = (close > tr_high_variance || close < tr_low_variance)
  end

  def six_month_profiles
    past_date = market_profile.day - 90
    MarketProfile.where(instrument: market_profile.instrument)
                 .where('CAST(day AS varchar) >= ? AND CAST(day AS varchar) < ?', past_date, market_profile.day)
  end
end
