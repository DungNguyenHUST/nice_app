class PostUnvotesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_unvote, only: [:destroy]
    
    def index 
        @post = Post.find(params[:post_id])
        @post_unvotes = @post.post_unvotes
    end

    def new
        @post = Post.find(params[:post_id])
        @post_unvote = PostUnvote.new(post_unvote_param)
        flash[:notice] = "You can't unvote more than once"
    end

    def create
        @post = Post.find(params[:post_id])
        @post_unvote = PostUnvote.new(post_unvote_param)
        if already_unvoted?
            # flash[:notice] = "You can't unvote more than once"
            redirect_to root_path
        else
            @post_unvote = @post.post_unvotes.create(post_unvote_param)
            @post_unvote.user_id = current_user.id
            if @post_unvote.save
                redirect_to post_path(@post)
            end
        end
        # redirect_to post_path(@post)
        # respond_to do |format|
        #     format.html {}
        #     format.js
        # end
    end

    def edit
    end

    def update
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @post_unvote = @post.post_unvotes.find(params[:id])
        @post_unvote.destroy
        redirect_to post_path(@post)
        # respond_to do |format|
        #     format.html {}
        #     format.js
        # end
    end

    def show
    end

    private

    def post_unvote_param
        params.permit(:id, :post_id)
    end

    def already_unvoted?
        PostUnvote.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end

    def find_unvote
        @unvote = @post.post_unvotes.find(params[:id])
    end
end
