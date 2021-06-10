class PostSavesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @post = Post.find(params[:post_id])
        @post_saves = @post.post_saves
    end

    def new
        @post = Post.find(params[:post_id])
        @post_save = PostSave.new
    end

    def create
        @post = Post.find(params[:post_id])
        @post_save = PostSave.new
        if !already_saved?
            @post_save = @post.post_saves.build(user_id: current_user.id)
            @post_save.save!
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
        @post_save = @post.post_saves.find(params[:id])
        @post_save.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

    private

    def already_saved?
        PostSave.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end
end
