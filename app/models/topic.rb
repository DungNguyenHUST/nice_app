class Topic < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    
	mount_uploader :avatar, ImageUploader
	mount_uploader :cover_image, ImageUploader
	
	has_many :topings
  	has_many :posts, through: :topings
      
  	has_many :topic_follows, dependent: :destroy
    has_many :topic_reports, dependent: :destroy

    belongs_to :category, optional: true

	def self.search(search)
        if search
            target_search = Topic.where("name ILIKE?", "%#{search}%")
            if(target_search)
                self.where(id: target_search)
            end
        end
    end
end
