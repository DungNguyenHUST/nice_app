class PostVotesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @post = Post.find(params[:post_id])
        @post_votes = @post.post_votes
    end

    def new
        @post = Post.find(params[:post_id])
        @post_vote = PostVote.new
    end

    def create
        @post = Post.find(params[:post_id])
        @post_vote = PostVote.new

        if !already_voted?
            # Deleted unvoted
            pre_unvote = @post.post_unvotes.find { |unvote| unvote.user_id == current_user.id}
            if pre_unvote
                @post_unvote = @post.post_unvotes.find(pre_unvote.id)
                @post_unvote.destroy
            end

            # Created voted
            @post_vote = @post.post_votes.build(user_id: current_user.id)
            @post_vote.save!
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

    def already_voted?
        PostVote.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end
end
