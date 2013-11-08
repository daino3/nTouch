require 'spec_helper'

describe Event do

	it { should belong_to(:friend) }
	it { should have_one(:reminder) }
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:date) }
	it { should validate_presence_of(:friend_id) }

end