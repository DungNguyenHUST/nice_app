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
            @owner_post_comments = PostComment.where(user_id: user.id)
            @owner_post_comments.each do |post_comment|
                @owner_posts.push(post_comment.commentable)
            end
        end
        return @owner_posts
    end

    def find_owner_post_vote_for_user(user)
        @owner_posts = []
        if user.id.present?
            @owner_post_votes = PostVote.where(user_id: user.id)
            @owner_post_votes.each do |post_vote|
                @owner_posts.push(post_vote.post)
            end
        end
        return @owner_posts
    end

    def find_owner_post_unvote_for_user(user)
        @owner_posts = []
        if user.id.present?
            @owner_post_unvotes = PostUnvote.where(user_id: user.id)
            @owner_post_unvotes.each do |post_unvote|
                @owner_posts.push(post_unvote.post)
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
