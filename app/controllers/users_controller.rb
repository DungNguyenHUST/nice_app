class UsersController < ApplicationController
    before_action :require_login, only: [:index, :show, :edit, :update, :destroy]
    
    def index
        @users = User.all
    end

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
    end

    def show
        @user = current_user

        if(params.has_key?(:tab_id))
            @tab_id = params[:tab_id]
        else
            @tab_id = "default"
        end
    end

    def edit
        @user = User.find params[:id]
        
        if(params.has_key?(:tab_id))
            @tab_id = params[:tab_id]
        else
            @tab_id = "default"
        end
    end

    def destroy
        @user = User.find params[:id]
        @user.destroy
        redirect_to pages_path
    end

    def update
        @user = User.find params[:id]
        @user.update_without_password(user_params)
        redirect_to edit_user_path(@user)
    end

    def try(arg)
        self[arg] rescue nil
    end

    def wellcome
        @tags = Tag.all
    end

private
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :phone,:address, 
                                    :sign, :education,:job, :site, :birth_day, :company, :school, :introduce, :cover_image,
                                    :noti_when_message, :noti_when_tagging, :noti_when_follow, :noti_when_vote,
                                    :noti_when_unvote, :noti_when_report, :noti_weekly)
    end
end
