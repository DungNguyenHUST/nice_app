class Tag < ApplicationRecord
	mount_uploader :avatar, ImageUploader
	has_many :taggings
  	has_many :posts, through: :taggings
  	has_many :tag_follows, dependent: :destroy
end
