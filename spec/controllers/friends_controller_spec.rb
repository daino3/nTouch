require 'spec_helper'
require 'faker'

describe FriendsController do
  before :each do
    friend = Friend.create(user_id: rand(1..100), first_name: Faker::Name.name, last_name: Faker::Name.name, email: Faker::Internet.email, birthday: Time.gm(rand(2013..2020),rand(1..12),rand(1..28)).to_date)
    session[:friend_id] = friend.id
  end

  # describe "POST#create" do
  #   it "should create a friend" do
  #     expect {post :create, new_friend: FactoryGirl.attributes_for(:friend)
  #       }.to change(Friend, :count).by(1)
  #   end
  # end

end  
