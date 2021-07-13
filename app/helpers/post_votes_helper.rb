module PostVotesHelper
    def count_post_upvote(post)
        post.post_votes.where(vote_type: 1).count
    end

    def count_post_downvote(post)
        post.post_votes.where(vote_type: 0).count
    end

    def count_post_vote(post)
        post.post_votes.where(vote_type: 1).count - post.post_votes.where(vote_type: 0).count
    end
end
