module PostCommentsHelper
	def find_owner_user_for_post_comment(post_comment)
        @owner_user = User.first
        if post_comment.user_id.present?
            @owner_user = User.find_by(id: post_comment.user_id)
        end
        return @owner_user
    end
end
