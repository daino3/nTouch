require 'spec_helper'

describe User do
	it { should validate_presence_of(:first_name) }
	it { should validate_presence_of(:last_name) }
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:phone_number) }	

	# context "if user with email 'a@b.c' tries to sign in" do
	# 	pending
	# 	@user.email = 'a@b.c'
	# 	@user.should_not be_valid
	# end

	it { should have_many(:friends) }
end