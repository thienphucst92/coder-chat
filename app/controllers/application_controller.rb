class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :require_login, only: [:inbox]

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    return !session[:user_id].nil?
  end

  private
    def require_login
      unless signed_in?
        flash[:error] = "You must be sign in to view this page!"
        redirect_to login_path
      end
    end

    def skip_if_logged_in
      if signed_in?
        redirect_to inbox_path
      end
    end
end
