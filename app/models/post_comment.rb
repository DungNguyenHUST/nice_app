class PostComment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    has_many :post_comments, as: :commentable
    has_many :post_comment_votes, dependent: :destroy
    has_many :post_comment_unvotes, dependent: :destroy
    has_many :post_comment_saves, dependent: :destroy
end
