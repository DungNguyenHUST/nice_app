class PostsController < ApplicationController
    include PostsHelper
    include PostCommentsHelper

    before_action :set_post, only: %i[ show edit update destroy ]
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

    # GET /posts or /posts.json
    def index
        @posts = Post.all.page(params[:page]).per(10)
    end

    # GET /posts/1 or /posts/1.json
    def show
        @post = Post.friendly.find(params[:id])
        @post.increment!(:view_count)
        @post_images = @post.post_images.all
        @post_comments = @post.post_comments

        # Sort comment
        if(params.has_key?(:tab_id))
            @tab_id = params[:tab_id]
        else
            @tab_id = "default"
        end

        if "default" == @tab_id || "PostCommentBest" == @tab_id
            @buffers = @post.post_comments.sort_by{|post_comment| cal_post_comment_best_point(post_comment)}.reverse
            @post_comments = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end
    
        if "PostCommentNew" == @tab_id
            @buffers = @post.post_comments.order('created_at DESC')
            @post_comments = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end

        if "PostCommentTop" == @tab_id
            @buffers = @post.post_comments.sort_by{|post_comment| cal_post_comment_top_point(post_comment)}.reverse
            @post_comments = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end

        if "PostCommentOld" == @tab_id
            @buffers = @post.post_comments.order('created_at DESC').reverse
            @post_comments = Kaminari.paginate_array(@buffers).page(params[:page]).per(10)
        end

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    # GET /posts/new
    def new
        @post = Post.new
        @post_image = @post.post_images.build
        @post_link = @post.post_links.build

        # handle share
        @post_shared = nil
        if (params.has_key?(:post_shared_id))
            @post_shared = Post.friendly.find(params[:post_shared_id])
        end

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
            # save image
            if(params.has_key?(:post_images))
                params[:post_images]['image'].each do |a|
                    @post_image = @post.post_images.create!(:image => a, :post_id => @post.id)
                end
            end
            
            # count number of share
            if @post.post_shared_id.present? && @post.post_shared_id > 0
                @post_shared = Post.friendly.find(@post.post_shared_id)
                @post_shared.increment!(:share_count)
            end

            # save link data
            if(@post.link.present?)
                @link = LinkThumbnailer.generate(@post.link)
                if @link.present?
                    image = ""
                    favicon = ""
                    title = ""
                    description = ""

                    if !@link.images.first.nil?
                        image = @link.images.first.src.to_s
                    end
                    if !@link.favicon.nil?
                        favicon = @link.favicon.to_s
                    end
                    if @link.title.present?
                        title = @link.title
                    end
                    if @link.description.present?
                        description = @link.description
                    end

                    @post_link = @post.post_links.create!(:image => image,
                                                            :favicon => favicon,
                                                            :title => title,
                                                            :description => description,
                                                            :post_id => @post.id)
                end
            end

            redirect_to post_path(@post)
        end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
        if @post.update(post_params)
            if(params.has_key?(:post_images))
                params[:post_images]['image'].each do |a|
                    @post_image = @post.post_images.create!(:image => a, :post_id => @post.id)
                end
            end
        end
        redirect_to post_path(@post)
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
        @post = Post.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
        params.require(:post).permit(:title, :content, :content_rich_text, :link, :podcast, :view_count, :post_shared_id, :share_count,
                                    :topic_list, :topic, { topic_ids: [] }, :topic_ids, 
                                    post_images_attributes: [:id, :post_id, :image])
    end
end
