module PostsHelper
include PostVotesHelper
include UsersHelper
    def cal_post_for_you_point(post)
        if(post.post_comments.count > 0)
            post_commments = post.post_comments.sort_by{|post_comment| post_comment.created_at}.reverse
            lastest_comment = post_commments.first
            comment_point = Time.now - lastest_comment.created_at
        else
            comment_point = Time.now - post.created_at
        end
        return comment_point
    end

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

    def prepare_page_for_you
        # For logged in user
        processing_datas = []
        if user_signed_in?
            # Find post by followed user
            followed_users = current_user.followees
            followed_users.each do |followed_user|
                post_by_followed_users = find_owner_post_for_user(followed_user)
                post_by_followed_users.each do |post_by_followed_user|
                    processing_datas.push(post_by_followed_user)
                end
            end

            # Find post by followed topic
            followed_topics = find_owner_topic_follow_for_user(current_user)
            followed_topics.each do |followed_topic|
                post_by_followed_topics = followed_topic.posts
                post_by_followed_topics.each do |post_by_followed_topic|
                    processing_datas.push(post_by_followed_topic)
                end
            end

            # Remove duplicate data 
            processing_datas.uniq{ |post| [post.id]}

            # Sort data by lastest comment
            processing_datas = processing_datas.sort_by{|post| cal_post_for_you_point(post)}
        else
            # For 
            processing_datas = Post.all
            processing_datas = processing_datas.sort_by{|post| cal_post_for_you_point(post)}
        end

        return processing_datas
    end
end
