# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do 

  user = User.create(first_name: Faker::Name.name, last_name: Faker::Name.name, email: Faker::Internet.email)
  friend = Friend.create(user_id: rand(1..100), first_name: Faker::Name.name, last_name: Faker::Name.name, email: Faker::Internet.email, birthday: Time.gm(rand(2013..2020),rand(1..12),rand(1..28)).to_date)
  event = Event.create(friend_id: rand(1..100), title: Faker::Name.name, description: Faker::Company.bs, date: Time.gm(rand(2013..2020),rand(1..12),rand(1..28)).to_date, notification_date: Time.gm(rand(2013..2020),rand(1..12),rand(1..28)).to_date)
  test_events = Event.create(friend_id: rand(1..100), title: Faker::Name.name, description: Faker::Company.bs, date: Time.now.to_date)
  reminder_receipts = ReminderReceipt.create(event_id: rand(1..100), status: ["true", "false"].sample)
end