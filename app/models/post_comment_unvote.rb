class PostCommentUnvote < ApplicationRecord
	belongs_to :post_comments, optional: true
end
