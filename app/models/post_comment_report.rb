class PostCommentReport < ApplicationRecord
    belongs_to :post_comment, optional: true
end
