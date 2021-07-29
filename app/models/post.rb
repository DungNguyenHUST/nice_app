class Post < ApplicationRecord
    extend FriendlyId
    def convert_slug
        slug = title.downcase.to_s
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

    has_many :post_votes, dependent: :destroy
    has_many :post_follows, dependent: :destroy
    has_many :post_reports, dependent: :destroy
    has_many :post_comments, as: :commentable

    has_many :post_images
    accepts_nested_attributes_for :post_images

    has_many :post_links

    has_many :topings
    has_many :topics, through: :topings

    has_rich_text :content_rich_text

    mount_uploader :podcast, FileUploader

    def self.topicged_with(name)
        Topic.find_by!(name: name).posts
    end

    def self.topic_counts
        Topic.select('topics.*, count(topings.topic_id) as count').joins(:topings).group('topings.topic_id')
    end

    def topic_list
        topics.map(&:name).join(', ')
    end

    def topic_list=(names)
        self.topics = names.split(',').map do |n|
            Topic.where(name: n.strip).first_or_create!
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
