module UsersHelper
    def find_owner_post_for_user(user)
        @owner_posts = Post.first
        if user.id.present?
            @owner_posts = Post.where(user_id: user.id)
        end
        return @owner_posts
    end

    def find_owner_topic_for_user(user)
        @owner_topics = Topic.first
        if user.id.present?
            @owner_topics = Topic.where(user_id: user.id)
        end
        return @owner_topics
    end

    def find_owner_topic_follow_for_user(user)
        @user_owner_topics = []
        if user.id.present?
            @owner_topic_follows = TopicFollow.where(user_id: user.id)
            @owner_topic_follows.each do |topic_follow|
                @user_owner_topics.push(topic_follow.topic)
            end

            @owner_topics = Topic.where(user_id: user.id)
            @owner_topics.each do |topic|
                @user_owner_topics.push(topic)
            end
        end
        return @user_owner_topics
    end

    def find_owner_post_comment_for_user(user)
        @owner_posts = []
        if user.id.present?
            @owner_post_comments = PostComment.where(user_id: user.id, commentable_type: "Post")
            @owner_post_comments.each do |post_comment|
                @owner_posts.push(post_comment.commentable)
            end
        end
        return @owner_posts
    end

    def find_owner_post_upvote_for_user(user)
        @owner_posts = []
        if user.id.present?
            @owner_post_upvotes = PostVote.where(user_id: user.id, vote_type: 1)
            @owner_post_upvotes.each do |post_upvote|
                @owner_posts.push(post_upvote.post)
            end
        end
        return @owner_posts
    end

    def find_owner_post_downvote_for_user(user)
        @owner_posts = []
        if user.id.present?
            @owner_post_downvotes = PostVote.where(user_id: user.id, vote_type: 0)
            @owner_post_downvotes.each do |post_downvote|
                @owner_posts.push(post_downvote.post)
            end
        end
        return @owner_posts
    end

    def find_owner_post_save_for_user(user)
        @owner_posts = []
        if user.id.present?
            @owner_post_saves = PostFollow.where(user_id: user.id)
            @owner_post_saves.each do |post_save|
                @owner_posts.push(post_save.post)
            end
        end
        return @owner_posts
    end
end
