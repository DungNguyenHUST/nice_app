class PostUnvotesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @post = Post.find(params[:post_id])
        @post_unvotes = @post.post_unvotes
    end

    def new
        @post = Post.find(params[:post_id])
        @post_unvote = PostUnvote.new
    end

    def create
        @post = Post.find(params[:post_id])
        @post_unvote = PostUnvote.new
        if !already_unvoted?
            @post_unvote = @post.post_unvotes.build(user_id: current_user.id)
            @post_unvote.save!
        end
    end

    def edit
    end

    def update
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @post_unvote = @post.post_unvotes.find(params[:id])
        @post_unvote.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

    private

    def already_unvoted?
        PostUnvote.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end
end
