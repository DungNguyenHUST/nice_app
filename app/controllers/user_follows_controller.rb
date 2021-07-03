class UserFollowsController < ApplicationController
	before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @user = User.friendly.find(params[:user_id])
    end

    def new
        @user = User.friendly.find(params[:user_id])
        @user_follow = UserFollow.new
    end

    def create
        @user = User.friendly.find(params[:user_id])
        @owner_user = current_user
        @user_follow = UserFollow.new
        if !already_followed?
            @user_follow = UserFollow.create(follower_id: current_user.id, followee_id: @user.id)
            @user_follow.save!
        end
        @type_param = params[:type_param]

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def edit
    end

    def update
    end
    
    def destroy
        @user = User.friendly.find(params[:user_id])
        @owner_user = current_user
        @user_follow = @user.following_users.find(params[:id])
        @user_follow.destroy
        @type_param = params[:type_param]
        
        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

private

    def already_followed?
        current_user.following_users.find { |follow| follow.followee_id == current_user.id }
    end
end
