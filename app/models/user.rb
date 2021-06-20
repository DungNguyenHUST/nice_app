class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  mount_uploader :avatar, ImageUploader
  mount_uploader :cover_image, ImageUploader

  has_many :user_notifications, dependent: :destroy

  # List follower of current user
  has_many :followed_users, foreign_key: :follower_id, class_name: "UserFollow"
  has_many :followees, through: :followed_users, source: :person_being_followed

  # List following of current user
  has_many :following_users, foreign_key: :followee_id, class_name: "UserFollow"
  has_many :followers, through: :following_users, source: :person_doing_the_following

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.avatar = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
