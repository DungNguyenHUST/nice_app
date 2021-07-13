class PostVotesController < ApplicationController
    include ApplicationHelper
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @post = Post.friendly.find(params[:post_id])
        @post_votes = @post.post_votes
    end

    def new
        @post = Post.friendly.find(params[:post_id])
        @post_vote = PostVote.new
    end

    def create
        @post = Post.friendly.find(params[:post_id])
        @type_param = params[:type_param]

        @vote = @post.post_votes.find { |vote| (vote.user_id == current_user.id) && (vote.vote_type == 0 || vote.vote_type == 1)}

        if !@vote.nil?
            @vote.update(vote_type: params[:vote_type])
        else
            # Created voted
            @post_vote = @post.post_votes.build(user_id: current_user.id, vote_type: params[:vote_type])
            @post_vote.save!
            
            # Notify user
            if(find_owner_user(@post).present?)
                destination_user = find_owner_user(@post)
                trigger_user = current_user
                title = @post.title
                content = @post.content
                original_url = post_path(@post)
                type = "PostVote"
                UserNotificationsController.new.create_notify(destination_user, trigger_user, title, content, original_url, type)
            end
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
        @post = Post.friendly.find(params[:post_id])
        @post_vote = @post.post_votes.find(params[:id])
        @post_vote.destroy
        @type_param = params[:type_param]

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

    private
end
