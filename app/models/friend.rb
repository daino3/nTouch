class Friend < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  attr_accessible :first_name, :last_name, :birthday, :user_id, :email, :photo_url, :uid, :phone_number

  validates_presence_of :first_name, :last_name, :birthday

  def self.get_facebook_interactions(graph, friend_uid)
    posts_from_friend = facebook_friend_to_me(graph, friend_uid)
    posts_from_me     = facebook_me_to_friend(graph, friend_uid)
    {friend_uid: friend_uid, friend: posts_from_friend, me: posts_from_me}
  end

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

  def self.check_new_friend(current_user, new_friend)
    if current_user.friends.find_by_uid(new_friend.uid)
      "#{new_friend.first_name} is already included in your list. Please select someone who is not."
    else
      current_user.friends << new_friend
      "#{new_friend.first_name} has been added to your list"
    end
  end

  def self.update_friend(params)
    Friend.find(params[:id]).update_attributes(params[:friend])
    Friend.find(params[:id])
  end
end
