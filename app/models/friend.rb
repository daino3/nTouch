class Friend < ActiveRecord::Base
	belongs_to :user
	has_many :events

	attr_accessible :first_name, :last_name, :birthday, :user_id, :email

	validates_presence_of :first_name, :last_name, :birthday

end
