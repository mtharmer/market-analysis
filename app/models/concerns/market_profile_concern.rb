# frozen_string_literal: true

module MarketProfileConcern
  extend ActiveSupport::Concern

  # INITIAL BALANCE AND TRUE RANGE HELPERS
  # --------------------------------------
  def tr_high_variance
    high - (metric.true_range * 0.25)
  end

  def tr_low_variance
    low + (metric.true_range * 0.25)
  end

  def wide_true_range?
    metric.z_score_true_range >= 1
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
    metric.z_score_initial_balance > -1 && metric.z_score_initial_balance < 0.5
  end

  def narrow_initial_balance?
    metric.z_score_initial_balance <= -1
  end

  def wide_initial_balance?
    metric.z_score_initial_balance >= 0.5
  end

  def unbroken?
    !metric.broken_low && !metric.broken_high
  end

  def one_sided_break?
    (metric.broken_high ^ metric.broken_low)
  end

  def two_sided_break?
    metric.broken_low && metric.broken_high
  end

  def any_break?
    metric.broken_low || metric.broken_high
  end

  def all_skinny_tpos?
    tpos.map { _1.letters.length }.max <= 5
  end

  def add_for_singles
    required = 1
    required += 1 if tpos.find { _1.price == high }&.letters&.length == 1
    required += 1 if tpos.find { _1.price == low }&.letters&.length == 1
    required
  end

  def nodes_separated_by_single_print?
    required = add_for_singles
    single_print_tpos = tpos.map { _1.letters.length == 1 ? 1 : nil }
    groups = single_print_tpos.select.with_index do |tpo, idx|
      !tpo.nil? && single_print_tpos[idx + 1].nil?
    end

    groups.length >= required
  end

  def day_finder # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    # normal, normal-variation, trend, double-distribution, non-trend, neutral, neutral-extreme
    if unbroken?
      # normal, non-trend
      wide_initial_balance? ? 'normal' : 'non_trend'
    elsif all_skinny_tpos?
      'trend'
    elsif nodes_separated_by_single_print?
      'double_distribution'
    elsif two_sided_break?
      # neutral, neutral-extreme
      metric.close_within_range ? 'neutral' : 'neutral_extreme'
    elsif one_sided_break?
      'normal_variation'
    else
      ''
    end
  end
  # --------------------------------------

  def overtaken_open?
    tpos.find { _1.price == open }&.letters&.length&.> 2
  end

  def btwn(item, h_val, l_val)
    item >= l_val && item <= h_val
  end

  # OPENING TYPE METHODS
  # ////////////////////

  def opening_type_finder # rubocop:disable Metrics/AbcSize
    if btwn(open, low + tick_variation, low) || btwn(open, high, high - tick_variation)
      'open_drive'
    elsif overtaken_open? && !two_sided_break?
      'open_rejection_reverse'
    elsif !two_sided_break?
      'open_test_drive'
    else
      'open_auction'
    end
  end

  # DAY TYPE DETERMINISTIC METHODS
  # ==============================
  # def normal_day?
  # Characterized by :
  # wide initial balance;
  # unbroken IB (within 1-2 ticks)
  #   (wide_initial_balance? || moderate_initial_balance?) &&
  #     unbroken?
  # end

  # def normal_variation_day?
  # Characterized by:
  # wide initial balance - TODO? ~50% of day's range;
  # IB High XOR IB Low is broken (not both)
  # wide_initial_balance? &&
  #   moderate_initial_balance? &&
  #     one_sided_break?
  # end

  # def neutral_day?
  # Characterized by:
  # moderate or wide initial balance;
  # close between the initial balance range;
  # both IB high and low are broken
  #   (moderate_initial_balance? || wide_initial_balance?) &&
  #     metric.close_within_range &&
  #     two_sided_break?
  # end

  # def neutral_extreme_day?
  # Characterized by:
  # moderate or wide initial balance;
  # IB high and low are broken;
  # close is near a high/low (not in the middle like neutral)
  #   (moderate_initial_balance? || wide_initial_balance?) &&
  #     two_sided_break? &&
  #     !neutral_day?
  # end

  # def non_trend_day?
  # Characterized by:
  # narrow initial balance;
  # no range extensions
  #   narrow_initial_balance? &&
  #     unbroken?
  # end

  # def trend_day?
  # Characterized by:
  # wide initial balance;
  # wide true range;
  # one-sided IB break;
  # close near day extreme (within 25% of high/low of range)
  #   wide_initial_balance? &&
  #     wide_true_range? &&
  #     one_sided_break? &&
  #     metric.close_near_extreme?
  # end

  # def double_distribution_day?
  # Characterized by:
  # narrow initial balance;
  # wide day range;
  # close near day extremen (within 25% of high/low of range)
  #   narrow_initial_balance? &&
  #     any_break? &&
  #     wide_true_range? &&
  #     metric.close_near_extreme? &&
  #     !trend_day?
  # end
  # ==============================
end
