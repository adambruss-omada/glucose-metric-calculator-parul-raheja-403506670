puts "Clearing old data..."
GlucoseLevel.delete_all
Member.delete_all

puts "Creating members..."
members = 100.times.map do
  Member.create!(name: Faker::Name.name)
end

puts "Creating glucose levels..."
members.each do |member|
  readings = 200.times.map do
    {
      member_id: member.id,
      value: rand(40..300),
      tested_at: rand(60).days.ago.change(hour: rand(0..23), min: rand(0..59)),
      tz_offset: "-04:00",
      created_at: Time.zone.now,
      updated_at: Time.zone.now
    }
  end

  GlucoseLevel.insert_all(readings)
end

puts "✅ Done seeding!"
