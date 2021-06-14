class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    has_many :post_votes, dependent: :destroy
    has_many :post_unvotes, dependent: :destroy
    has_many :post_saves, dependent: :destroy
    has_many :post_comments, as: :commentable

    has_many :taggings
    has_many :tags, through: :taggings

    def self.tagged_with(name)
        Tag.find_by!(name: name).posts
    end

    def self.tag_counts
        Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
    end

    def tag_list
        tags.map(&:name).join(', ')
    end

    # def tag_list
    #     self.tags.collect do |tag|
    #         tag.name
    #     end.join(", ")
    # end

    def tag_list=(names)
        self.tags = names.split(',').map do |n|
          Tag.where(name: n.strip).first_or_create!
        end
    end
end
