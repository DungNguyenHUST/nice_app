module PostCommentsHelper
	def find_owner_user_for_post_comment(post_comment)
        if post_comment.user_id.present?
            @owner_user = User.friendly.find(post_comment.user_id)
        end
        return @owner_user
    end

    def cal_post_comment_top_point(post_comment)
        vote_count = post_comment.post_comment_votes.count
        unvote_count = post_comment.post_comment_unvotes.count
        point = vote_count - unvote_count
        return point
    end

    def cal_post_comment_best_point(post_comment)
        vote_count = post_comment.post_comment_votes.count
        unvote_count = post_comment.post_comment_unvotes.count
        reply_count = post_comment.post_comments.count
        point = (vote_count - unvote_count) + reply_count
        return point
    end
end
