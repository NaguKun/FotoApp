class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]

  has_many :photos
  has_many :albums
  has_many :reactions, dependent: :destroy
  
  has_many :active_friendships, foreign_key: "follower_id", class_name: "Follow", dependent: :destroy
  has_many :passive_friendships, foreign_key: "followed_id", class_name: "Follow", dependent: :destroy

  has_many :following, through: :active_friendships , source: :followed
  has_many :followers, through: :passive_friendships , source: :follower

  has_one_attached :avatar
  
  def follow(user)
    active_friendships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_friendships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

  def admin?
    role == 'admin'
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      if auth.provider == "google_oauth2"
        user.firstname = auth.info.first_name
        user.lastname = auth.info.last_name
      elsif auth.provider == "facebook"
        user.firstname = auth.info.name.split(" ")[0]
        user.lastname = auth.info.name.split(" ")[1]
      end
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.password_confirmation = user.password
    end
  end

end