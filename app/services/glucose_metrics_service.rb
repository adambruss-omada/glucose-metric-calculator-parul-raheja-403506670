class GlucoseMetricsService
    def initialize(member_id)
      @member_id = member_id
    end
  
    def average_glucose
      {
        last_7_days: compute_average(7.days.ago.beginning_of_day..Time.zone.now.end_of_day),
        prior_7_days: compute_average(14.days.ago.beginning_of_day..8.days.ago.end_of_day),
        this_month: compute_average(Time.zone.now.beginning_of_month..Time.zone.now.end_of_day),
        last_month: compute_average(1.month.ago.beginning_of_month..1.month.ago.end_of_month)
      }.tap do |metrics|
        metrics[:delta_7_day] = delta(metrics[:last_7_days], metrics[:prior_7_days])
        metrics[:delta_month] = delta(metrics[:this_month], metrics[:last_month])
      end
    end

    def percent_below_range
        {
            last_7_days: compute_percent_below_range(7.days.ago.beginning_of_day..Time.zone.now.end_of_day),
            prior_7_days: compute_percent_below_range(14.days.ago.beginning_of_day..8.days.ago.end_of_day),
            this_month: compute_percent_below_range(Time.zone.now.beginning_of_month..Time.zone.now.end_of_day),
            last_month: compute_percent_below_range(1.month.ago.beginning_of_month..1.month.ago.end_of_month)
        }.tap do |metrics|
            metrics[:delta_7_day] = delta(metrics[:last_7_days], metrics[:prior_7_days])
            metrics[:delta_month] = delta(metrics[:this_month], metrics[:last_month])
        end
    end

    def percent_above_range
        {
            last_7_days: compute_percent_above_range(7.days.ago.beginning_of_day..Time.zone.now.end_of_day),
            prior_7_days: compute_percent_above_range(14.days.ago.beginning_of_day..8.days.ago.end_of_day),
            this_month: compute_percent_above_range(Time.zone.now.beginning_of_month..Time.zone.now.end_of_day),
            last_month: compute_percent_above_range(1.month.ago.beginning_of_month..1.month.ago.end_of_month)
        }.tap do |metrics|
            metrics[:delta_7_day] = delta(metrics[:last_7_days], metrics[:prior_7_days])
            metrics[:delta_month] = delta(metrics[:this_month], metrics[:last_month])
        end
    end
  
    private
  
    def compute_average(range)
      GlucoseLevel.for_member(@member_id).average_reading(range)
    end

    def compute_percent_below_range(range)
        GlucoseLevel.for_member(@member_id).percent_below_range(range)
    end

    def compute_percent_above_range(range)
        GlucoseLevel.for_member(@member_id).percent_above_range(range)
    end
  
    def delta(current, previous)
      if current && previous
        return (current - previous).round(2)
      end
    end
end
  