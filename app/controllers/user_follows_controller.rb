class UserFollowsController < ApplicationController
	before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @user = User.find(params[:user_id])
        @user_follows = @user.user_follows
    end

    def new
        @user = User.find(params[:user_id])
        @user_follow = UserFollow.new
    end

    def create
        @user = User.find(params[:user_id])
        @user_follow = UserFollow.new
        if !already_followed?
            @user_follow = @user.user_follows.build(user_id: current_user.id)
            @user_follow.save!
        end

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
        @user = User.find(params[:user_id])
        @user_follow = @user.user_follows.find(params[:id])
        @user_follow.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

private

    def already_followed?
        UserFollow.where(followee_id: current_user.id, followee_id: params[:user_id]).exists?
    end
end
