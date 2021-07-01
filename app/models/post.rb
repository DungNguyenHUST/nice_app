class Post < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    has_many :post_votes, dependent: :destroy
    has_many :post_unvotes, dependent: :destroy
    has_many :post_follows, dependent: :destroy
    has_many :post_comments, as: :commentable

    has_many :post_images
    accepts_nested_attributes_for :post_images

    has_many :post_links

    has_many :taggings
    has_many :tags, through: :taggings

    has_rich_text :content_rich_text

    def self.tagged_with(name)
        Tag.find_by!(name: name).posts
    end

    def self.tag_counts
        Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
    end

    def tag_list
        tags.map(&:name).join(', ')
    end

    def tag_list=(names)
        self.tags = names.split(',').map do |n|
          Tag.where(name: n.strip).first_or_create!
        end
    end

    def self.search(search)
        if search
            target_search = Post.where("title ILIKE?", "%#{search}%")
            if(target_search)
                self.where(id: target_search)
            end
        end
    end
end
