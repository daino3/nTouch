class Friend < ActiveRecord::Base
	belongs_to :user
	has_many :events, dependent: :destroy

	attr_accessible :first_name, :last_name, :birthday, :user_id, :email, :photo_url, :uid, :phone_number

	validates_presence_of :first_name, :last_name, :birthday
end
