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
        @user.update(user_params)
    end

    def try(arg)
        self[arg] rescue nil
    end

private
    def user_params
        params.require(:user).permit :name, :email, :password, :password_confirmation, :phone, :address, :cover_letter , :cover_letter_attach, :avatar, :root, :admin, :user, :employer, :company, :company_id
    end
end
