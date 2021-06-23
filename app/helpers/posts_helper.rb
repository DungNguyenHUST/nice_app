module PostsHelper
    def find_owner_user_for_post(post)
        @owner_user = User.first
        if post.user_id.present?
            @owner_user = User.find_by(id: post.user_id)
        end
        return @owner_user
    end

    def find_owner_post_for_user(user)
        @owner_posts = Post.first
        if user.id.present?
            @owner_posts = Post.where(user_id: user.id)
        end
        return @owner_posts
    end

    def find_owner_tag_for_user(user)
        @owner_tags = []
        if user.id.present?
            @owner_tag_follows = TagFollow.where(user_id: user.id)
            @owner_tag_follows.each do |tag_follow|
                @owner_tags.push(tag_follow.tag)
            end
        end
        return @owner_tags
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

    def find_user_color(user_name)
        color_type = 0
        if user_name.present?
            case user_name[0].upcase
            when "A","Ă","Â"
                color_type = 1
            when "B","C","D"
                color_type = 2
            when "Đ","E","Ê","F"
                color_type = 3
            when "G","H","I","J","K"
                color_type = 4
            when "L","M","N"
                color_type = 5
            when "O","Ô","Ơ"
                color_type = 6
            when "P","Q","R"
                color_type = 7
            when "S","T","U","Ư"
                color_type = 8
            when "V","X","Y","Z"
                color_type = 9
            else
                color_type = 0
            end
        else
            color_type = 0 
        end
        
        return color_type
    end

    def get_domain_name(url)
        uri = url.split("/")[2].sub(/^www./,'').upcase
        return uri.to_s
    end
end
