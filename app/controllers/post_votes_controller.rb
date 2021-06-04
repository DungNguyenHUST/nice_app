class PostVotesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_vote, only: [:destroy]
    
    def index 
        @post = Post.find(params[:post_id])
        @post_votes = @post.post_votes
    end

    def new
        @post = Post.find(params[:post_id])
        @post_vote = PostVote.new
        flash[:notice] = "You can't vote more than once"
    end

    def create
        @post = Post.find(params[:post_id])
        @post_vote = PostVote.new
        @post_vote.user_id = current_user.id
        if already_voted?
            # flash[:notice] = "You can't vote more than once"
            redirect_to root_path
        else
            @post_vote = @post.post_votes.build
            @post_vote.save!
        end
        # redirect_to post_path(@post)
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
        @post_vote = @post.post_votes.find(params[:id])
        @post_vote.destroy
        redirect_to post_path(@post)
        # respond_to do |format|
        #     format.html {}
        #     format.js
        # end
    end

    def show
    end

    private

    def already_voted?
        PostVote.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end

    def find_vote
        @vote = @post.post_votes.find(params[:id])
    end
end
