class PostCommentReportsController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
    end

    def new
        @post_comment = PostComment.find(params[:post_comment_id])
        @post_comment_report = PostCommentReport.new
    end

    def create
        @post_comment = PostComment.find(params[:post_comment_id])
        @post_comment_report = @post_comment.post_comment_reports.build(post_comment_report_params)
        @post_comment_report.user_id = current_user.id
        
        if @post_comment_report.save
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
        @post_comment = PostComment.find(params[:post_comment_id])
        @post_comment_report = @post_comment.post_comment_reports.find(params[:id])
        @post_comment_report.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

    private
    def post_comment_report_params
        params.require(:post_comment_report).permit(:report_type, :report_content, :user_id)
    end
end
