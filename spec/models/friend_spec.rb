require 'spec_helper'

describe Friend do 

	it { should belong_to(:user) }
	it { should have_many(:events) }
	it { should validate_presence_of(:first_name) }
	it { should validate_presence_of(:last_name) }
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:phone_number) }	

	it "fails validation without unique email" do
	  user1 = FactoryGirl.create(:friend)
	  user2 = FactoryGirl.build(:friend)
	  user2.should_not be_valid
	  user2.should have(1).error_on(:email) 
	end
	describe "#create" do
  		it "is invalid without a firstname" do
  			FactoryGirl.build(:friend, first_name: nil).should_not be_valid
  		end
    
      	it "is invalid without a last name" do
  			FactoryGirl.build(:friend, last_name: nil).should_not be_valid
  		end

  		it "is invalid without a email" do
  			FactoryGirl.build(:friend, email: nil).should_not be_valid
  		end

    end
end	