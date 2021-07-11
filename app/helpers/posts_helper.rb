module PostsHelper
    def cal_post_top_point(post)
        vote_count = post.post_votes.count
        unvote_count = post.post_unvotes.count
        point = vote_count - unvote_count
        return point
    end

    def cal_post_hot_point(post)
        vote_count = post.post_votes.count
        unvote_count = post.post_unvotes.count
        comment_count = post.post_comments.count
        if post.view_count.present?
            view_count = post.view_count
        else
            view_count = 0
        end
        point = (vote_count - unvote_count) + view_count + comment_count
        return point
    end

    def cal_post_trend_point(post)
        if post.view_count.present?
            view_count = post.view_count
        else
            view_count = 0
        end
        point = view_count
        return point
    end
end
