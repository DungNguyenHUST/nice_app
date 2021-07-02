class TopicsController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
	before_action :set_topic, only: %i[ show edit update destroy ]

	def index
		@topics = Topic.all.page(params[:page]).per(20)
	end

	def show
		@posts = @topic.posts

		@tab_id = "default"
	    if(params.has_key?(:tab_id))
	        @tab_id = params[:tab_id]
	    end
	end

	def new
		@topic = Topic.new
	end	

	def create
		@topic = Topic.new(topic_params)
	    if @topic.save
	      	redirect_to root_path
	    end
	end

	def update
	end

	def destroy
	end

private
	def topic_params
      	params.require(:topic).permit(:name, :description, :avatar, :cover_image)
    end

	def set_topic
      	@topic = Topic.friendly.find(params[:id])
    end
end
