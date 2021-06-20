class TagsController < ApplicationController
	before_action :set_tag, only: %i[ show edit update destroy ]

	def index
		@tags = Tag.all
	end

	def show
		@posts = @tag.posts

		@tab_id = "default"
	    if(params.has_key?(:tab_id))
	        @tab_id = params[:tab_id]
	    end
	end

	def new
		@tag = Tag.new
	end	

	def create
		@tag = Tag.new(tag_params)
	    if @tag.save
	      	redirect_to root_path
	    end
	end

	def update
	end

	def destroy
	end

private
	def tag_params
      	params.require(:tag).permit(:name, :description, :avatar, :cover_image)
    end

	def set_tag
      	@tag = Tag.find(params[:id])
    end
end
