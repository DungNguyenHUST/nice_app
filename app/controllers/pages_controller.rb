class PagesController < ApplicationController
    include PostsHelper
    include TopicsHelper
    include Kaminari
    
    def home
        @posts = Post.all.page(params[:page]).per(25)
        @topics = Topic.all.sort_by{|topic| cal_topic_trend_point(topic)}.reverse.first(10)

        @tab_id = "default"
        if(params.has_key?(:tab_id))
            @tab_id = params[:tab_id]
        end

        if "default" == @tab_id || "PostForYou" == @tab_id
            @buffers = prepare_page_for_you
            @posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(25)
        end

        if "PostTrendID" == @tab_id
            @buffers = Post.where("created_at >= ?", 1.week.ago.utc)
            @buffers = @buffers.sort_by{|post| cal_post_trend_point(post)}.reverse
            @posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(25)
        end

        if "PostNewID" == @tab_id
            @buffers = Post.where("created_at >= ?", 1.week.ago.utc)
            @posts = @buffers.order('created_at DESC').page(params[:page]).per(25)
        end

        if "PostTopID" == @tab_id
            @buffers = Post.all.sort_by{|post| cal_post_top_point(post)}.reverse
            @posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(25)
        end

        if "PostTopWeekID" == @tab_id
            @buffers = Post.where("created_at >= ?", 1.week.ago.utc)
            @buffers = @buffers.sort_by{|post| cal_post_top_point(post)}.reverse
            @posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(25)
        end

        if "PostTopMonthID" == @tab_id
            @buffers = Post.where("created_at >= ?", 1.month.ago.utc)
            @buffers = @buffers.sort_by{|post| cal_post_top_point(post)}.reverse
            @posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(25)
        end

        if "PostTopYearID" == @tab_id
            @buffers = Post.where("created_at >= ?", 1.year.ago.utc)
            @buffers = @buffers.sort_by{|post| cal_post_top_point(post)}.reverse
            @posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(25)
        end

        if "PostPodID" == @tab_id
            @buffers = Post.where("podcast <> ''")
            @buffers = @buffers.sort_by{|post| cal_post_trend_point(post)}.reverse
            @posts = Kaminari.paginate_array(@buffers).page(params[:page]).per(25)
        end

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def index
        @posts = Post.all.page(params[:page]).per(25)
        @topics = Topic.all.page(params[:page]).per(25)
    end

    def search
        if(params.has_key?(:search))
        @search = params[:search]
        @posts_search = Post.search(@search).page(params[:page]).per(25)
        @users_search = User.search(@search).page(params[:page]).per(25)
        @topics_search = Topic.search(@search).page(params[:page]).per(25)
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
