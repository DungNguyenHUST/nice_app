class PostReportsController < ApplicationController
    include ApplicationHelper
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @post = Post.friendly.find(params[:post_id])
        @post_reports = @post.post_reports
    end

    def new
        @post = Post.friendly.find(params[:post_id])
        @post_report = PostReport.new
    end

    def create
        @post = Post.friendly.find(params[:post_id])
        @post_report = @post.post_reports.build(post_report_params)
        
        if @post_report.save
            respond_to do |format|
                format.html {}
                format.js
            end
        end
    end

    def edit
    end

    def update
    end
    
    def destroy
        @post = Post.friendly.find(params[:post_id])
        @post_report = @post.post_reports.find(params[:id])
        @post_report.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

    private

    def post_report_params
        params.require(:post_report).permit(:report_type, :report_content, :user_id)
    end
end
