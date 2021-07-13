class PostCommentVotesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
	before_action :find_post_comment
    
    def index 
    end

    def new
        @post_comment = PostComment.find(params[:post_comment_id])
        @post_comment_vote = PostCommentVote.new
    end

    def create
        @post_comment = PostComment.find(params[:post_comment_id])

        @vote = @post_comment.post_comment_votes.find { |vote| (vote.user_id == current_user.id) && (vote.vote_type == 0 || vote.vote_type == 1)}

        if !@vote.nil?
            @vote.update(vote_type: params[:vote_type])
        else
            # Created voted
            @post_comment_vote = @post_comment.post_comment_votes.create(user_id: current_user.id, vote_type: params[:vote_type])
            @post_comment_vote.save!
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
        @post_comment = PostComment.find(params[:post_comment_id])
        @post_comment_vote = @post_comment.post_comment_votes.find(params[:id])
        @post_comment_vote.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

    private

    def find_post_comment
        @post_comment = PostComment.find(params[:post_comment_id])
    end
end
