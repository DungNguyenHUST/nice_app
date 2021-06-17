class PostsController < ApplicationController
  include PostsHelper
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @owner_user = find_owner_user_for_post(@post)
    @owner_post = find_owner_post_for_user(@owner_user)
  end

  # GET /posts/new
  def new
    @post = Post.new
    
    if(params.has_key?(:tab_id))
        @tab_id = params[:tab_id]
    else
        @tab_id = "default"
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :image, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
    end
end
