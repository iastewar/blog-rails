class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user
    unless user_signed_in?
      respond_to do |format|
        format.html { redirect_to new_session_path, alert: "Please sign in!" }
        format.js { render :authenticate_user }
      end
    end
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id] if session[:user_id]
  end
  helper_method :current_user # lets us use this method in views and controllers

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

end
