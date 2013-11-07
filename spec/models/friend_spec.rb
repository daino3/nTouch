require 'spec_helper'

describe Friend do 

	it { should belong_to(:user) }
	it { should have_many(:events) }

end	