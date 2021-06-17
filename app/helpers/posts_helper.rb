module PostsHelper
    def find_owner_user_for_post(post)
        @owner_user = User.first
        if post.user_id.present?
            @owner_user = User.find_by(id: post.user_id)
        end
        return @owner_user
    end

    def find_owner_post_for_user(user)
        @owner_post = Post.first
        if user.id.present?
            @owner_post = Post.where(user_id: user.id)
        end
        return @owner_post
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
end
