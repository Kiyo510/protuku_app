class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user
    unless logged_in?
      flash[:danger] = 'ログインが必要です。'
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
