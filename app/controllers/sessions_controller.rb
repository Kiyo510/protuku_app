# frozen_string_literal: true
# rubocop:disable all

class SessionsController < ApplicationController
  before_action :forbid_login_user, only: %i[new]

  def new; end

  def create
    if auth_hash.present?
      user = User.find_or_create_from_auth(auth_hash)
      user.accepts_terms!
      user.activate!
      log_in user
      flash[:success] = 'Twitterログインに成功しました。'
      redirect_to user
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user&.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          flash[:success] = 'ログインに成功しました。'
          redirect_to user
        else
          message  = 'アカウントが有効化されていません。 '
          message += 'Eメールのアカウント有効化リンクをクリックしてください。'
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'パスワードまたはEメールアドレスが間違っています。'
        render 'new'
      end
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
