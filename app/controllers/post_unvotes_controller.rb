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
            # Delete voted
            pre_vote = @post.post_votes.find { |vote| vote.user_id == current_user.id}
            if pre_vote
                @post_vote = @post.post_votes.find(pre_vote.id)
                @post_vote.destroy
            end

            # Create unvoted
            @post_unvote = @post.post_unvotes.build(user_id: current_user.id)
            @post_unvote.save!

            # Notify user
            if(find_owner_user(@post).present?)
                destination_user = find_owner_user(@post)
                trigger_user = current_user
                title = @post.title
                content = @post.content
                original_url = post_path(@post)
                type = "PostUnvote"
                UserNotificationsController.new.create_notify(destination_user, trigger_user, title, content, original_url, type)
            end
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
        @post = Post.find(params[:post_id])
        @post_unvote = @post.post_unvotes.find(params[:id])
        @post_unvote.destroy
        @type_param = params[:type_param]

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
