class Friend < ActiveRecord::Base
	belongs_to :user
	has_many :events, dependent: :destroy

	attr_accessible :first_name, :last_name, :birthday, :user_id, :email, :photo_url, :uid, :phone_number

	validates_presence_of :first_name, :last_name, :birthday

  def self.facebook_friend_to_me(graph, friend_uid)
    unix_time = (Time.now() - 3.months).to_i
    posts_from_friend_to_me = "SELECT message
                              FROM stream 
                              WHERE actor_id=#{friend_uid.to_i} AND source_id=me() AND created_time > #{unix_time} LIMIT 200" 
    graph.fql_query(posts_from_friend_to_me).count                          
  end

  def self.facebook_me_to_friend(graph, friend_uid)
    unix_time = (Time.now() - 3.months).to_i
    posts_from_me_to_friend = "SELECT message
                              FROM stream 
                              WHERE actor_id=me() AND source_id=#{friend_uid.to_i} AND created_time > #{unix_time} LIMIT 200"
    graph.fql_query(posts_from_me_to_friend).count
  end
end
