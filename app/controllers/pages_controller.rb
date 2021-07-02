class PagesController < ApplicationController
  include PostsHelper
  include Kaminari
  # GET /pages or /pages.json
  def index
    @posts = Post.all.page(params[:page]).per(10)
    @topics = Topic.all.sort_by{|topic| topic.topic_follows.count}.reverse.first(10)

    @tab_id = "default"
    if(params.has_key?(:tab_id))
        @tab_id = params[:tab_id]
    end

    if "default" == @tab_id || "PostHotID" == @tab_id
      @buffers = Post.all.sort_by{|post| cal_post_hot_point(post)}.reverse
      @post_hots = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
    end

    if "PostNewID" == @tab_id
      @post_news = Post.all.order('created_at DESC').page(params[:page]).per(10)
    end

    if "PostTopID" == @tab_id
      @buffers = Post.all.sort_by{|post| cal_post_top_point(post)}.reverse
      @post_tops = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
    end

    if "PostTrendID" == @tab_id
      @buffers = Post.where("created_at >= ?", 1.week.ago.utc)
      @buffers = @buffers.sort_by{|post| cal_post_trend_point(post)}.reverse
      @post_trends = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
    end

    @buffers = Post.where("created_at >= ?", 1.week.ago.utc)
    @post_trend_todays = @buffers.sort_by{|post| cal_post_trend_point(post)}.reverse.first(10)

  end

  def search
    if(params.has_key?(:search))
      @search = params[:search]
      @posts_search = Post.search(@search)
      @users_search = User.search(@search)
      @topics_search = Topic.search(@search)
    end

    @tab_id = "default"
    if(params.has_key?(:tab_id))
        @tab_id = params[:tab_id]
    end
  end

  # GET /pages/1 or /pages/1.json
  def show
  end

  # GET /pages/new
  def new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages or /pages.json
  def create
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
  end
end
