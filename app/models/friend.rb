class Friend < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :email, :birthday, :phone_number, :photo_name

	validates_presence_of :first_name, :last_name, :email, :phone_number
  	validates :email, format: { with: /\w+@\w+\.\w{2,3}/ }
  	validates :email, :phone_number, uniqueness: true

	belongs_to :user
	has_many :events

  attr_accessible :first_name, :last_name, :birthday
end
