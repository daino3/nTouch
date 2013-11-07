require 'spec_helper'

describe Event do

	it { should belong_to(:friend) }
	it { should have_one(:reminder) }

end