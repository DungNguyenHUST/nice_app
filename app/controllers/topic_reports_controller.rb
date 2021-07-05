class TopicReportsController < ApplicationController
    include ApplicationHelper
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
    
    def index 
        @topic = Topic.friendly.find(params[:topic_id])
        @topic_reports = @topic.topic_reports
    end

    def new
        @topic = Topic.friendly.find(params[:topic_id])
        @topic_report = TopicReport.new
    end

    def create
        @topic = Topic.friendly.find(params[:topic_id])
        @topic_report = @topic.topic_reports.build(topic_report_params)
        @topic_report.user_id = current_user.id
        
        if @topic_report.save
            redirect_to topic_path(@topic)
        #     respond_to do |format|
        #         format.html {}
        #         format.js
        #     end
        end
    end

    def edit
    end

    def update
    end
    
    def destroy
        @topic = Topic.friendly.find(params[:topic_id])
        @topic_report = @topic.topic_reports.find(params[:id])
        @topic_report.destroy

        respond_to do |format|
            format.html {}
            format.js
        end
    end

    def show
    end

    private

    def topic_report_params
        params.require(:topic_report).permit(:report_type, :report_content, :user_id)
    end
end
