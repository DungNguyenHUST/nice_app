class UsersController < ApplicationController
include UsersHelper
    before_action :require_login, only: [:index, :edit, :update, :destroy]
    
    def index
        @users = User.all
    end

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
    end

    def show
        @user = User.friendly.find params[:id]
        @topics = Topic.all.limit(10)
        if(params.has_key?(:tab_id))
            @tab_id = params[:tab_id]
        else
            @tab_id = "default"
        end
        
        if "default" == @tab_id || "UserPostID" == @tab_id
            @buffers = find_owner_post_for_user(@user)
            @user_posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end
    
        if "UserTopicID" == @tab_id
            @buffers = find_owner_topic_for_user(@user)
            @user_topics = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end
    
        if "UserTopicFollowID" == @tab_id
            @buffers = find_owner_topic_follow_for_user(@user)
            @user_topic_follows = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end
    
        if "UserCommentID" == @tab_id
            @buffers = find_owner_post_comment_for_user(@user)
            @user_comments = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end
    
        if "UserVoteID" == @tab_id
            @buffers = find_owner_post_upvote_for_user(@user)
            @user_votes = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end
    
        if "UserUnvoteID" == @tab_id
            @buffers = find_owner_post_downvote_for_user(@user)
            @user_unvotes = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end
    
        if "UserSaveID" == @tab_id
            @buffers = find_owner_post_save_for_user(@user)
            @user_saves = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end
    
        if "UserNotificationID" == @tab_id
            @buffers = @user.user_notifications
            @user_notifications = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end

        if "UserFollowingID" == @tab_id
            @buffers = @user.followers
            @user_followers = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end

        if "UserFollowedID" == @tab_id
            @buffers = @user.followees
            @user_followees = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end
    end

    def edit
        @user = User.friendly.find params[:id]
        
        if(params.has_key?(:tab_id))
            @tab_id = params[:tab_id]
        else
            @tab_id = "default"
        end
    end

    def destroy
        @user = User.friendly.find params[:id]
        @user.destroy
        redirect_to root_path
    end

    def update
        @user = User.friendly.find params[:id]
        @user.update_without_password(user_params)
        redirect_to edit_user_path(@user)
    end

    def try(arg)
        self[arg] rescue nil
    end

    def wellcome
        @topics = Topic.all
        @categories = Category.all
    end

private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :phone,:address, 
                                    :sign, :education,:job, :site, :birth_day, :company, :school, :introduce, :cover_image,
                                    :noti_when_message, :noti_when_tagging, :noti_when_follow, :noti_when_vote,
                                    :noti_when_unvote, :noti_when_report, :noti_weekly)
    end
end
