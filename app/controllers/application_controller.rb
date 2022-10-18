class ApplicationController < ActionController::Base
  before_action :require_login

  def require_login
    @current_user = User.find_by(id: session[:user_id])
    return if @current_user.present?

    redirect_to new_login_email_path(redirect_path: request.original_fullpath)
  end

  def self.logged_out_users_welcome!
    skip_before_action :require_login
  end
end
