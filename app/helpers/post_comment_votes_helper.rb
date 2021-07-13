module PostCommentVotesHelper
    def count_post_comment_upvote(post_comment)
        post_comment.post_comment_votes.where(vote_type: 1).count
    end

    def count_post_comment_downvote(post_comment)
        post_comment.post_comment_votes.where(vote_type: 0).count
    end

    def count_post_comment_vote(post_comment)
        post_comment.post_comment_votes.where(vote_type: 1).count - post_comment.post_comment_votes.where(vote_type: 0).count
    end
end
