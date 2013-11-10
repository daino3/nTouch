require 'spec_helper'

describe EventsController do
	before :each do
		event = Event.new(friend_id: rand(1..100),
		 description: "Birthday",
		 date: Date.today,
		 notification_date: Date.tomorrow)
	end

	# describe("POST#create") do
	# 	it "should create event" do
	# 		expect 
	# 	end
	# end
end