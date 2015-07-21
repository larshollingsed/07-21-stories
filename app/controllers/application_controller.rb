class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def log_user_in
    if session["user_id"]
      @user_logged_in = User.find(session["user_id"])
    end
  end
end
