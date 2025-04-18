
puts "Creating member..."
member = Member.find_or_create_by!(name: "Luke")

puts "Creating glucose data for member #{member.name}..."
20.times do |i|
  GlucoseLevel.create!(
    member_id: member.id,
    tested_at: i.days.ago,
    tz_offset: '-04:00',
    value: rand(40..600)
  )
end

puts "Glucose data created for member #{member.name}"
