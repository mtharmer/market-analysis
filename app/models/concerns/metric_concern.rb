# frozen_string_literal: true

module MetricConcern
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
end
