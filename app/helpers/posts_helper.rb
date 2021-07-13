module PostsHelper
include PostVotesHelper
    def cal_post_top_point(post)
        vote_count = count_post_vote(post)
        return vote_count
    end

    def cal_post_hot_point(post)
        vote_count = count_post_vote(post)
        comment_count = post.post_comments.count
        if post.view_count.present?
            view_count = post.view_count
        else
            view_count = 0
        end
        point = vote_count + view_count + comment_count
        return point
    end

    def cal_post_trend_point(post)
        comment_count = post.post_comments.count
        if post.view_count.present?
            view_count = post.view_count
        else
            view_count = 0
        end
        point = view_count + comment_count
        return point
    end
end
