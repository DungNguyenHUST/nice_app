class TagFollowsController < ApplicationController
	before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @tag = Tag.find(params[:tag_id])
        @tag_follows = @tag.tag_follows
    end

    def new
        @tag = Tag.find(params[:tag_id])
        @tag_follow = TagFollow.new
    end

    def create
        @tag = Tag.find(params[:tag_id])
        @tag_follow = TagFollow.new
        if !already_followd?
            @tag_follow = @tag.tag_follows.build(user_id: current_user.id)
            @tag_follow.save!
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
        @tag = Tag.find(params[:tag_id])
        @tag_follow = @tag.tag_follows.find(params[:id])
        @tag_follow.destroy
        @type_param = params[:type_param]
        
        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

    private

    def already_followd?
        TagFollow.where(user_id: current_user.id, tag_id: params[:tag_id]).exists?
    end
end
