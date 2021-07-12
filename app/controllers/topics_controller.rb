class TopicsController < ApplicationController
	include PostsHelper
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
	before_action :set_topic, only: %i[ show edit update destroy ]

	def index
		@topics = Topic.all.page(params[:page]).per(20)
	end

	def show
		@topic_posts = @topic.posts

		@tab_id = "default"
	    if(params.has_key?(:tab_id))
	        @tab_id = params[:tab_id]
	    end

		if "default" == @tab_id || "TopicPostForYou" == @tab_id
			@buffers = @topic_posts.sort_by{|post| cal_post_hot_point(post)}.reverse
			@posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
		end
	
		if "TopicPostTrendID" == @tab_id
			@buffers = @topic_posts.sort_by{|post| cal_post_trend_point(post)}.reverse
			@posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
		end
	
		if "TopicPostNewID" == @tab_id
      		@posts = @topic_posts.order('created_at DESC').page(params[:page]).per(10)
		end
	
		if "TopicPostTopID" == @tab_id
			@buffers = @topic_posts.sort_by{|post| cal_post_top_point(post)}.reverse
			@posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
		end
	
		if "TopicPostTopWeekID" == @tab_id
			# @buffers = @topic_posts.where("created_at >= ?", 1.week.ago.utc)
			@buffers = @buffers.sort_by{|post| cal_post_top_point(post)}.reverse
			@posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
		end
	
		if "TopicPostTopMonthID" == @tab_id
			# @buffers = @topic_posts.where("created_at >= ?", 1.month.ago.utc)
			@buffers = @buffers.sort_by{|post| cal_post_top_point(post)}.reverse
			@posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
		end
	
		if "TopicPostTopYearID" == @tab_id
			# @buffers = @topic_posts.where("created_at >= ?", 1.year.ago.utc)
			@buffers = @buffers.sort_by{|post| cal_post_top_point(post)}.reverse
			@posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
		end
	
		if "TopicPostPodID" == @tab_id
			@buffers = @topic_posts.where("podcast <> ''")
			@buffers = @buffers.sort_by{|post| cal_post_trend_point(post)}.reverse
			@posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
		end
	end

	def new
		@topic = Topic.new
	end	

	def create
		@topic = Topic.new(topic_params)
		@topic.user_id = current_user.id
	    if @topic.save
	      	redirect_to categories_path
	    end
	end

	def update
	end

	def destroy
	end

private
	def topic_params
      	params.require(:topic).permit(:name, :description, :avatar, :cover_image, :category_id)
    end

	def set_topic
      	@topic = Topic.friendly.find(params[:id])
    end
end
