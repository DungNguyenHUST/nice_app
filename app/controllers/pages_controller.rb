class PagesController < ApplicationController
  include PostsHelper
  include Kaminari
  # GET /pages or /pages.json
  def index
    @posts = Post.all.page(params[:page]).per(10)

    @buffers = Post.all.sort_by{|post| cal_post_top_point(post)}.reverse
    @post_tops = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)

    @post_news = Post.all.order('created_at DESC').page(params[:page]).per(10)

    @buffers = Post.all.sort_by{|post| cal_post_hot_point(post)}.reverse
    @post_hots = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)

    @post_trends = Post.all.page(params[:page]).per(10)

    @tags = Tag.all

    @tab_id = "default"
    if(params.has_key?(:tab_id))
        @tab_id = params[:tab_id]
    end
  end

  def search
    if(params.has_key?(:search))
      @search = params[:search]
      @posts_search = Post.search(@search)
      @users_searchs = User.search(@search)
      @tags_search = Tag.search(@search)
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
