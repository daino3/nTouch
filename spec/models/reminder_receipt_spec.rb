require 'spec_helper'

describe ReminderReceipt do

	it { should belong_to(:event) }

		it "is invalid without an event_id" do
			FactoryGirl.build(:reminder_receipt, event_id: nil).should_not be_valid
		end
end