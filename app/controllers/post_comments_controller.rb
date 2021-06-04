class PostCommentsController < ApplicationController
    before_action :find_commentable, only: :create

    def new
        @post_comment = PostComment.new
    end

    def create
        @commentable.post_comments.build(post_comment_params)
        @commentable.user_id = current_user.id
        if @commentable.save
            respond_to do |format|
                format.html {}
                format.js
            end 
        end
    end

    private

    def post_comment_params
        params.require(:post_comment).permit(:content)
    end

    def find_commentable
        if params[:post_comment_id]
            @commentable = PostComment.find_by_id(params[:post_comment_id]) 
            @post_comment = @commentable
        elsif params[:post_id]
            @commentable = Post.find_by_id(params[:post_id])
            @post = @commentable
        end
    end
end
