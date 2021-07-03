class PostCommentsController < ApplicationController
    include ApplicationHelper
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_commentable, only: :create

    def new
        @post_commenter = PostComment.new
    end

    def create
        @post_commenter = @commentable.post_comments.build(post_comment_params)
        @post_commenter.user_id = current_user.id
        if @post_commenter.save
            # redirect_to post_path(@post)

            if @is_post_comment
                # Notify user
                if(find_owner_user(@post).present?)
                    destination_user = find_owner_user(@post)
                    trigger_user = current_user
                    if @post.title.present?
                        title = @post.title
                    else
                        title = ''
                    end
                    if @post.content.present?
                        content = @post.content
                    else
                        content = ''
                    end
                    original_url = post_path(@post)
                    type = "PostComment"
                    UserNotificationsController.new.create_notify(destination_user, trigger_user, title, content, original_url, type)
                end
            else
                if(find_owner_user(@post_comment).present?)
                    destination_user = find_owner_user(@post_comment)
                    trigger_user = current_user

                    if @post_comment.commentable.title.present?
                        title = @post_comment.commentable.title
                    else
                        title = ''
                    end

                    if @post_comment.content.present?
                        content = @post_comment.content
                    else
                        content = ''
                    end
                    original_url = post_path(@post_comment.commentable)
                    type = "PostReplyComment"
                    UserNotificationsController.new.create_notify(destination_user, trigger_user, title, content, original_url, type)
                end
            end
            
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
        @is_post_comment = false
        if params[:post_comment_id]
            @commentable = PostComment.find(params[:post_comment_id]) 
            @post_comment = @commentable
            @is_post_comment = false
        elsif params[:post_id]
            @commentable = Post.friendly.find(params[:post_id])
            @post = @commentable
            @is_post_comment = true
        end
    end
end
