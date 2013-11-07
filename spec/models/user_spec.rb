require 'spec_helper'

describe User do
	it { should validate_presence_of(:first_name) }
	it { should validate_presence_of(:last_name) }
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:phone_number) }	

  	describe "#create" do
    	it "should require an email, a password and a password confirmation" do
	      user = User.new()
	      user.save.should eq false
	  end
    end

	it { should have_many(:friends) }
end  
