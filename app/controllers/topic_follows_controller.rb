class TopicFollowsController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @topic = Topic.friendly.find(params[:topic_id])
        @topic_follows = @topic.topic_follows
    end

    def new
        @topic = Topic.friendly.find(params[:topic_id])
        @topic_follow = TopicFollow.new
    end

    def create
        @topic = Topic.friendly.find(params[:topic_id])
        @topic_follow = TopicFollow.new
        if !already_followd?
            @topic_follow = @topic.topic_follows.build(user_id: current_user.id)
            @topic_follow.save!
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
        @topic = Topic.friendly.find(params[:topic_id])
        @topic_follow = @topic.topic_follows.find(params[:id])
        @topic_follow.destroy
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
        TopicFollow.where(user_id: current_user.id, topic_id: params[:topic_id]).exists?
    end
end
