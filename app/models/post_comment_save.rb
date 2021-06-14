class PostCommentSave < ApplicationRecord
	belongs_to :post_comments, optional: true
end
