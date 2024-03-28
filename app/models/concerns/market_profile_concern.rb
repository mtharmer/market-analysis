# frozen_string_literal: true

module MarketProfileConcern # rubocop:disable Metrics/ModuleLength
  extend ActiveSupport::Concern

  # GENERAL MATH HELPERS
  # ////////////////////
  def mean(arr)
    arr.sum(0.0) / arr.size
  end

  def stdev(arr)
    mean = mean(arr)
    sum = arr.sum(0.0) { |element| (element - mean)**2 }
    variance = sum / (arr.size - 1)
    Math.sqrt(variance)
  end

  def median(arr)
    arr.sort!
    if arr.size.even?
      arr[arr.size / 2]
    else
      arr[(arr.size - 1) / 2]
    end
  end

  def z_score(item, arr)
    (item - mean(arr)) / stdev(arr)
  end
  # ////////////////////

  # INITIAL BALANCE AND TRUE RANGE HELPERS
  # --------------------------------------
  def average_initial_balance
    mean(instrument.market_profiles.map(&:initial_balance))
  end

  def ib_stdev
    stdev(instrument.market_profiles.map(&:initial_balance))
  end

  def ib_z
    z_score(initial_balance, instrument.market_profiles.map(&:initial_balance))
  end

  def median_ib
    median(instrument.market_profiles.map(&:initial_balance))
  end

  def average_true_range
    mean(instrument.market_profiles.map(&:true_range))
  end

  def true_range_stdev
    stdev(instrument.market_profiles.map(&:true_range))
  end

  def true_range
    high - low
  end

  def true_range_high
    high - (true_range * 0.25)
  end

  def true_range_low
    low + (true_range * 0.25)
  end

  def wide_true_range?
    true_range > (average_true_range + true_range_stdev)
  end

  def tick_variation
    instrument.tick_size * 2
  end

  def ib_high_variance
    initial_balance_high + tick_variation
  end

  def ib_low_variance
    initial_balance_low - tick_variation
  end

  def moderate_initial_balance?
    # !narrow_initial_balance? && !wide_initial_balance? && !very_wide_initial_balance?
    # ib_z.between?(-0.5, 0.25)
    ib_z > -0.75 && ib_z < 0.75
  end

  def narrow_initial_balance?
    # initial_balance < (average_initial_balance - ib_stdev)
    ib_z <= -0.75
  end

  def wide_initial_balance?
    # initial_balance >= average_initial_balance && !very_wide_initial_balance?
    ib_z >= 0.75 # && ib_z < 1
  end

  # def very_wide_initial_balance?
    # initial_balance >= (average_initial_balance + ib_stdev)
    # ib_z >= 1
  # end
  # --------------------------------------

  # DAY TYPE DETERMINISTIC METHODS
  # ==============================
  def normal_day?
    # Characterized by :
    # wide initial balance;
    # unbroken IB (within 1-2 ticks)
    wide_initial_balance? &&
      high <= ib_high_variance &&
      low >= ib_low_variance
  end

  def normal_variation_day?
    # Characterized by:
    # wide initial balance - TODO? ~50% of day's range;
    # IB High XOR IB Low is broken (not both)
    wide_initial_balance? &&
      ((high > ib_high_variance) ^ (low < ib_low_variance))
    # ^ XOR on range extension
  end

  def neutral_day?
    # Characterized by:
    # moderate initial balance;
    # close between the initial balance range;
    # both IB high and low are broken
    moderate_initial_balance? &&
      # close.between?(ib_high_variance, ib_low_variance) &&
      close >= ib_low_variance && close <= ib_high_variance &&
      high > ib_high_variance &&
      low < ib_low_variance
  end

  def neutral_extreme_day?
    # Characterized by:
    # moderate initial balance;
    # IB high and low are broken
    moderate_initial_balance? &&
      high > ib_high_variance &&
      low < ib_low_variance
  end

  def non_trend_day?
    # Characterized by:
    # narrow initial balance;
    # no range extensions
    narrow_initial_balance? &&
      high <= ib_high_variance &&
      low >= ib_low_variance
  end

  def trend_day?
    # Characterized by:
    # wide initial balance;
    # wide true range;
    # one-sided IB break;
    # close near day extreme (within 25% of high/low of range)
    wide_initial_balance? &&
      wide_true_range? &&
      ((high > ib_high_variance) ^ (low < ib_low_variance)) &&
      # ^ XOR on range extension
      (close > true_range_high || close < true_range_low)
    # ^ close is near an extreme
  end

  def double_distribution_day?
    # Characterized by:
    # narrow initial balance;
    # wide day range;
    # close near day extremen (within 25% of high/low of range)
    narrow_initial_balance? &&
      wide_true_range? &&
      (close > true_range_high || close < true_range_low)
  end
  # ==============================
end
