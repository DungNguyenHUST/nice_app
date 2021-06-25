class Tag < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    
	mount_uploader :avatar, ImageUploader
	mount_uploader :cover_image, ImageUploader
	
	has_many :taggings
  	has_many :posts, through: :taggings
  	has_many :tag_follows, dependent: :destroy

	def self.search(search)
        if search
            target_search = Post.where("name ILIKE?", "%#{search}%")
            if(target_search)
                self.where(id: target_search)
            end
        end
    end
end
