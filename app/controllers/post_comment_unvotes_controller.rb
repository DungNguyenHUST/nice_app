class PostCommentUnvotesController < ApplicationController
	before_action :find_post_comment
    before_action :find_post_comment_unvote, only: [:destroy]
    
    def index 
        @post = Post.find(params[:post_id])
        @post_comments = @post.post_comments
        @post_comment_unvotes = @post_comments.post_comment_unvotes
    end

    def new
        @post = Post.find(params[:post_id])
        @post_comment = @post.post_comments.find(params[:post_comment_id])
        @post_comment_unvote = PostCommentUnvote.new
    end

    def create
        @post = Post.find(params[:post_id])
        @post_comment = PostComment.find(params[:post_comment_id])
        if !already_unvoted?
            @post_comment_unvote = @post_comment.post_comment_unvotes.create(user_id: current_user.id)
            @post_comment_unvote.save!
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
        @post_comment = @post.post_comments.find(params[:post_comment_id])
        @post_comment_unvote = @post_comment.post_comment_unvotes.find(params[:id])
        @post_comment_unvote.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
        @post = Post.find(params[:post_id])
        @post_comment = @post.post_comments.find(params[:post_comment_id])
        @post_comment_unvote = @post_comment.post_comment_unvotes.find(params[:id])
    end

    private

    def already_unvoted?
        PostCommentUnvote.where(user_id: current_user.id, post_comment_id: params[:post_comment_id]).exists?
    end

    def find_post_comment
        @post_comment = PostComment.find(params[:post_comment_id])
    end

    def find_post_comment_unvote
        @unvote = @post_comment.post_comment_unvotes.find(params[:id])
    end
end
