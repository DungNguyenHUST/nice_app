class CategoriesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
	before_action :set_category, only: %i[ show edit update destroy ]

	def index
		@categories = Category.all
	end

	def show
	end

	def new
		@category = Category.new
	end	

	def create
		@category = Category.new(category_params)
        @category.user_id = current_user.id
	    if @category.save
	      	redirect_to category_path(@category)
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
