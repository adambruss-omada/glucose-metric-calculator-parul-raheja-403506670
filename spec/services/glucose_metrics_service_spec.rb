require 'rails_helper'

RSpec.describe GlucoseMetricsService, type: :service do
  let(:member) { create(:member) }
  let(:other_member) { create(:member) }

  before do
    travel_to(Time.zone.local(2025, 5, 29, 12, 0, 0)) do
      create(:glucose_level, member: member, value: 60, tested_at: 1.day.ago, tz_offset: "+00:00")
      create(:glucose_level, member: member, value: 200, tested_at: 1.day.ago, tz_offset: "+00:00")
      create(:glucose_level, member: member, value: 210, tested_at: 2.days.ago, tz_offset: "+00:00")
      create(:glucose_level, member: member, value: 10, tested_at: 3.day.ago, tz_offset: "+00:00")

      create(:glucose_level, member: member, value: 40, tested_at: 8.days.ago, tz_offset: "+00:00") 
      create(:glucose_level, member: member, value: 190, tested_at: 10.days.ago, tz_offset: "+00:00")

      create(:glucose_level, member: member, value: 210, tested_at: Time.zone.local(2025, 5, 1, 10), tz_offset: "+00:00")
      create(:glucose_level, member: member, value: 80, tested_at: Time.zone.local(2025, 5, 1, 10), tz_offset: "+00:00")
      create(:glucose_level, member: member, value: 40, tested_at: Time.zone.local(2025, 5, 1, 10), tz_offset: "+00:00")

      create(:glucose_level, member: member, value: 210, tested_at: Time.zone.local(2025, 4, 1, 10), tz_offset: "+00:00")
      create(:glucose_level, member: member, value: 80, tested_at: Time.zone.local(2025, 4, 1, 10), tz_offset: "+00:00")
      create(:glucose_level, member: member, value: 40, tested_at: Time.zone.local(2025, 4, 1, 10), tz_offset: "+00:00")

      create(:glucose_level, member: other_member, value: 999, tested_at: 1.day.ago, tz_offset: "+00:00")
    end
  end

  describe '#average_glucose' do
    it 'returns correct averages and deltas' do
        travel_to(Time.zone.local(2025, 5, 29, 12, 0, 0)) do
        result = GlucoseMetricsService.new(member.id).average_glucose

        expect(result[:last_7_days]).to eq(120.0)
        expect(result[:prior_7_days]).to eq(115.0)
        expect(result[:this_month]).to eq(115.56)
        expect(result[:last_month]).to eq(110.0)

        expect(result[:delta_7_day]).to eq(5.0)
        expect(result[:delta_month]).to eq(5.56)
        end
    end

    it 'returns nil when there is no data' do
        empty_member = create(:member)
        result = GlucoseMetricsService.new(empty_member.id).average_glucose

        expect(result[:last_7_days]).to be_nil
        expect(result[:prior_7_days]).to be_nil
        expect(result[:this_month]).to be_nil
        expect(result[:last_month]).to be_nil
        expect(result[:delta_7_day]).to be_nil
        expect(result[:delta_month]).to be_nil
    end

    it 'does not include data from other members' do
        result = GlucoseMetricsService.new(member.id).average_glucose

        expect(result[:last_7_days]).not_to eq(999)
    end
  end

  describe '#percent_below_range' do
    it 'returns correct percentages and deltas' do
        travel_to(Time.zone.local(2025, 5, 29, 12, 0, 0)) do
            result = GlucoseMetricsService.new(member.id).percent_below_range

            expect(result[:last_7_days]).to eq(50.0)
            expect(result[:prior_7_days]).to eq(50.0)
            expect(result[:this_month]).to eq(44.44)
            expect(result[:last_month]).to eq(33.33)
            expect(result[:delta_7_day]).to eq(0.0)
            expect(result[:delta_month]).to eq(11.11)
        end
    end
 end


 describe '#percent_above_range' do
  it 'returns correct percentages and deltas' do
    travel_to(Time.zone.local(2025, 5, 29, 12, 0, 0)) do
      result = GlucoseMetricsService.new(member.id).percent_above_range

      expect(result[:last_7_days]).to eq(50.0)
      expect(result[:prior_7_days]).to eq(50.0)
      expect(result[:this_month]).to eq(44.44)
      expect(result[:last_month]).to eq(33.33)
      expect(result[:delta_7_day]).to eq(0.0)
      expect(result[:delta_month]).to eq(11.11)
    end
   end
  end
end
