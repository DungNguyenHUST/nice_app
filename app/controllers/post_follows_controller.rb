class PostFollowsController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @post = Post.find(params[:post_id])
        @post_follows = @post.post_follows
    end

    def new
        @post = Post.find(params[:post_id])
        @post_follow = PostFollow.new
    end

    def create
        @post = Post.find(params[:post_id])
        @post_follow = PostFollow.new
        if !already_followed?
            @post_follow = @post.post_follows.build(user_id: current_user.id)
            @post_follow.save!
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
        @post = Post.find(params[:post_id])
        @post_follow = @post.post_follows.find(params[:id])
        @post_follow.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

    private

    def already_followed?
        PostFollow.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end
end
