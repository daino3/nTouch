class User < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :email, :birthday, :phone_number, :photo_name


	validates_presence_of :first_name, :last_name, :email, :phone_number
  	validates :email, format: { with: /\w+@\w+\.\w{2,3}/ }
  	validates :email, uniqueness: true
	
	has_many :friends
end