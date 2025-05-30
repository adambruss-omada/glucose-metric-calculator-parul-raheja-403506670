class GlucoseLevel < ApplicationRecord
    belongs_to :member

    HIGH_THRESHOLD = 180
    LOW_THRESHOLD = 70
  
    scope :for_member, ->(member_id) { where(member_id: member_id) }
  
    def self.average_reading(range)
      where(tested_at: range).average(:value)&.round(2)
    end

    def self.percent_above_range(range)
        readings = where(tested_at: range)
        readings_count = readings.count
        return 0.0 if readings_count == 0
    
        above = readings.where("value > ?", HIGH_THRESHOLD).count
        ((above.to_f / readings_count) * 100).round(2)
    end

    def self.percent_below_range(range)
        readings = where(tested_at: range)
        readings_count = readings.count
        return 0.0 if readings_count == 0

        below = readings.where("value < ?", LOW_THRESHOLD).count
        ((below.to_f / readings_count) * 100).round(2)
    end
end