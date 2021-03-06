class Topic < ApplicationRecord
    extend FriendlyId
    def convert_slug
        slug = name.downcase.to_s
        slug.gsub! /[àáạãảâậấẫầẩăặắằẵẳ]/, "a"
        slug.gsub! /[đ]/, "d"
        slug.gsub! /[èéẹẽẻêềếệễể]/, "e"
        slug.gsub! /[óòọõỏôốồộỗổơớợỡờở]/, "o"
        slug.gsub! /[úùụũủưứựừữử]/, "u"
        slug.gsub! /[íịìĩỉ]/, "i"
        slug.gsub! /[ýỵỹỳỷ]/, "y"
        return slug
    end
    friendly_id :convert_slug, use: :slugged
    
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
