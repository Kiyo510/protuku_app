class SessionsController < ApplicationController
  before_action :forbid_login_user, only: %i[new]

  def new; end

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
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
end
