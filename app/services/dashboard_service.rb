# frozen_string_literal: true

class DashboardService
  # def initialize
  # end

  def call
    {
      day_type_by_opening: day_type_by_opening,
      opening_type_by_day: opening_type_by_day
    }
  end

  def day_type_by_opening
    MarketProfile.all.map(&:opening_type).uniq.flat_map do |opening_type|
      sql = <<-SQL.squish
        select opening_type, day_type, count(day_type),
        100.0 * count(day_type) / (select count(day_type)
        from market_profiles where opening_type = '#{opening_type}') AS Ratio
        from market_profiles where opening_type = '#{opening_type}'
        group by opening_type, day_type order by Ratio desc;
      SQL
      MarketProfile.connection.select_all(sql)
    end
  end

  def opening_type_by_day
    MarketProfile.all.map(&:day_type).uniq.flat_map do |day_type|
      sql = <<-SQL.squish
        select day_type, opening_type, count(opening_type),
        100.0 * count(opening_type) / (select count(opening_type)
        from market_profiles where day_type = '#{day_type}') AS Ratio
        from market_profiles where day_type = '#{day_type}'
        group by day_type, opening_type order by Ratio desc;
      SQL
      MarketProfile.connection.select_all(sql)
    end
  end
end
