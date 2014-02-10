class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :birthday, :phone_number, :photo_url, :time_zone

  validates_presence_of :first_name, :last_name, :email

  validates :email, format: { with: /\w+@\w+\.\w{2,3}/ }, uniqueness: true

  has_many :friends, dependent: :destroy

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.extra.raw_info.first_name
      user.last_name = auth.extra.raw_info.last_name
      user.email = auth.extra.raw_info.email
      user.photo_url = auth.info.image
      user.birthday = Date.strptime(auth.extra.raw_info.birthday, "%m/%d/%Y")
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      return user
    end
  end
end
