FactoryBot.define do
  factory :glucose_level do
    tested_at { 1.hour.ago }
    tz_offset { '-04:00' }
    value { '120' }
  end
end
