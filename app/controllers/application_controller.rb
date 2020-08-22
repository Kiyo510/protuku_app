class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user
    unless logged_in?
      flash[:danger] = "ログインをして下さい。"
      redirect_to login_url
    end
  end
end
