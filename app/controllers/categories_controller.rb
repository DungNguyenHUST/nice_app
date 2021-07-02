class CategoriesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
	before_action :set_category, only: %i[ show edit update destroy ]

	def index
		@categories = Category.all.page(params[:page]).per(20)
	end

	def show
		@posts = @category.posts

		@tab_id = "default"
	    if(params.has_key?(:tab_id))
	        @tab_id = params[:tab_id]
	    end
	end

	def new
		@category = Category.new
	end	

	def create
		@category = Category.new(category_params)
        @category.user_id = current_user.id
	    if @category.save
	      	redirect_to root_path
	    end
	end

	def update
	end

	def destroy
	end

private
	def category_params
      	params.require(:category).permit(:name, :description)
    end

	def set_category
      	@category = Category.friendly.find(params[:id])
    end
end
