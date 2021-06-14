class PostCommentVotesController < ApplicationController
	before_action :find_post_comment
    before_action :find_post_comment_vote, only: [:destroy]
    
    def index 
        @post = Post.find(params[:post_id])
        @post_comments = @post.post_comments
        @post_comment_votes = @post_comments.post_comment_votes
    end

    def new
        @post = Post.find(params[:post_id])
        @post_comment = @post.post_comments.find(params[:post_comment_id])
        @post_comment_vote = PostCommentVote.new
    end

    def create
        @post = Post.find(params[:post_id])
        @post_comment = PostComment.find(params[:post_comment_id])
        if !already_voted?
            @post_comment_vote = @post_comment.post_comment_votes.create(user_id: current_user.id)
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
        @post = Post.find(params[:post_id])
        @post_comment = @post.post_comments.find(params[:post_comment_id])
        @post_comment_vote = @post_comment.post_comment_votes.find(params[:id])
        @post_comment_vote.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
        @post = Post.find(params[:post_id])
        @post_comment = @post.post_comments.find(params[:post_comment_id])
        @post_comment_vote = @post_comment.post_comment_votes.find(params[:id])
    end

    private

    def already_voted?
        PostCommentVote.where(user_id: current_user.id, post_comment_id: params[:post_comment_id]).exists?
    end

    def find_post_comment
        @post_comment = PostComment.find(params[:post_comment_id])
    end

    def find_post_comment_vote
        @vote = @post_comment.post_comment_votes.find(params[:id])
    end
end
