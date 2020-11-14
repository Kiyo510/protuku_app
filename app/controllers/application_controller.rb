# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user
    return if logged_in?

    flash[:danger] = 'ログインが必要です。'
    redirect_to login_url
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(items_path) unless current_user?(@user)
  end
end
