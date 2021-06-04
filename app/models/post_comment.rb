class PostComment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    has_many :post_comments, as: :commentable
end
