class PostCommentSavesController < ApplicationController
	before_action :find_post_comment
    before_action :find_post_comment_save, only: [:destroy]
    
    def index 
        @post = Post.find(params[:post_id])
        @post_comments = @post.post_comments
        @post_comment_saves = @post_comments.post_comment_saves
    end

    def new
        @post = Post.find(params[:post_id])
        @post_comment = @post.post_comments.find(params[:post_comment_id])
        @post_comment_save = PostCommentSave.new
    end

    def create
        @post = Post.find(params[:post_id])
        @post_comment = PostComment.find(params[:post_comment_id])
        if !already_saved?
            @post_comment_save = @post_comment.post_comment_saves.create(user_id: current_user.id)
            @post_comment_save.save!
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
        @post_comment_save = @post_comment.post_comment_saves.find(params[:id])
        @post_comment_save.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
        @post = Post.find(params[:post_id])
        @post_comment = @post.post_comments.find(params[:post_comment_id])
        @post_comment_save = @post_comment.post_comment_saves.find(params[:id])
    end

    private

    def already_saved?
        PostCommentSave.where(user_id: current_user.id, post_comment_id: params[:post_comment_id]).exists?
    end

    def find_post_comment
        @post_comment = PostComment.find(params[:post_comment_id])
    end

    def find_post_comment_save
        @save = @post_comment.post_comment_saves.find(params[:id])
    end
end
