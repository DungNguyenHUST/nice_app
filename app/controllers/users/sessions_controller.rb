# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # before_action :save_my_previous_url, only: [:new]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource_or_scope)
    # case session[:my_previous_url]
    # when new_user_session_path
    # when user_session_path
    # when destroy_user_session_path
    # when user_facebook_omniauth_authorize_path
    # when user_facebook_omniauth_callback_path
    # when user_google_oauth2_omniauth_authorize_path
    # when user_google_oauth2_omniauth_callback_path
    # when new_user_password_path
    # when edit_user_password_path
    # when user_password_path
    # when cancel_user_registration_path
    # when new_user_registration_path
    # when edit_user_registration_path
    # when user_registration_path
    # when users_path
    # when new_user_path
    # when edit_user_path(current_user)
    # when user_path(current_user)
    #   session[:my_previous_url] = root_path
    # else
    # end

    # Show wellcome path
    if current_user.sign_in_count == 0
      current_path = user_wellcome_path
    else
      current_path = request.referrer
    end
    current_user.increment!(:sign_in_count)

    stored_location_for(resource_or_scope) || current_path
  end

  # def save_my_previous_url
  #   session[:my_previous_url] = URI(request.referer || '').path
  # end
end
