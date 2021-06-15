class Tag < ApplicationRecord
	has_many :taggings
  	has_many :posts, through: :taggings
  	has_many :tag_follows, dependent: :destroy
end
