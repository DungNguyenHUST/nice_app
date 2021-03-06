# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
	# devise :users, omniauth_providers: [:google]
	before_action :save_my_previous_url, only: [:new]
	skip_before_action :verify_authenticity_token, only: :facebook

	def google_oauth2
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
		flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
		sign_in_and_redirect @user, event: :authentication
		else
		# session["devise.omniauth_callbacks"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
		redirect_to new_user_session_url
		end
	end

	def facebook
		# You need to implement the method below in your model (e.g. app/models/user.rb)
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
		flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Facebook'
		sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
		else
		# session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
		redirect_to new_user_session_url
		end
	end

	def failure 
		redirect_to root_path 
	end 

	# You should also create an action method in this controller like this:
	# def twitter
	# end

	# More info at:
	# https://github.com/heartcombo/devise#omniauth

	# GET|POST /resource/auth/twitter
	# def passthru
	#   super
	# end

	# GET|POST /users/auth/twitter/callback
	# def failure
	#   super
	# end

	protected

	# The path used when OmniAuth fails
	def after_omniauth_failure_path_for(_scope)
		new_users_session_path
	end
	
	# The path used after sign in.
	def after_sign_in_path_for(resource_or_scope)
        if (session[:my_previous_url].to_s == new_user_session_path || 
            session[:my_previous_url].to_s == user_session_path || 
            session[:my_previous_url].to_s == destroy_user_session_path || 
            session[:my_previous_url].to_s == user_facebook_omniauth_authorize_path || 
            session[:my_previous_url].to_s == user_facebook_omniauth_callback_path || 
            session[:my_previous_url].to_s == user_google_oauth2_omniauth_authorize_path || 
            session[:my_previous_url].to_s == user_google_oauth2_omniauth_callback_path || 
            session[:my_previous_url].to_s == new_user_password_path || 
            session[:my_previous_url].to_s == edit_user_password_path || 
            session[:my_previous_url].to_s == user_password_path || 
            session[:my_previous_url].to_s == cancel_user_registration_path || 
            session[:my_previous_url].to_s == new_user_registration_path || 
            session[:my_previous_url].to_s == edit_user_registration_path || 
            session[:my_previous_url].to_s == user_registration_path || 
            session[:my_previous_url].to_s == users_path || 
            session[:my_previous_url].to_s == new_user_path || 
            session[:my_previous_url].to_s == edit_user_path(current_user) || 
            session[:my_previous_url].to_s == user_path(current_user))
            
            session[:my_previous_url] = root_path
        end

		# Show wellcome path
        if current_user.sign_in_count == 0
            session[:my_previous_url] = user_wellcome_path
        end

        stored_location_for(resource_or_scope) || session[:my_previous_url]
    end

	def save_my_previous_url
        session[:my_previous_url] = URI(request.referer || '').path
    end

end
