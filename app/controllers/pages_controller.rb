class PagesController < ApplicationController
  # GET /pages or /pages.json
  def index
    @posts = Post.all.order('created_at DESC')
    
    if current_user.present?
      # @tag_follows = TagFollow.where(user_id: current_user.id)
      @tags = Tag.all
    else
      @tags = Tag.all
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
