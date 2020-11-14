# frozen_string_literal: true

class UsersController < ApplicationController
  include SetRoomForDirectMessage
  before_action :authenticate_user, only: %i[edit update]
  before_action :correct_user, only: %i[edit update]
  before_action :forbid_login_user, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = 'アカウント有効用のメールを送信しました。クリックして有効化をお願い致します。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました。'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    # ストック一覧を取得
    stock_items = Stock.get_stock_items(@user)
    @stock_items = Kaminari.paginate_array(stock_items).page(params[:stocks_page]).per(10)
    # 投稿した履歴を取得
    posted_items = @user.items
    @posted_items = Kaminari.paginate_array(posted_items).page(params[:items_page]).per(10)
    if logged_in?
    # Entryモデルからログインユーザーのレコードを抽出
      @current_user_entry = Entry.where(user_id: current_user.id)
      # Entryモデルからメッセージ相手のレコードを抽出
      @another_user_entry = Entry.where(user_id: @user.id)
      set_room_for_direct_message unless @user.id == current_user.id
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.avatar.attach(params[:avatar]) if @user.avatar.blank?
    if @user.update(user_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = '退会処理が完了しました。またのご利用お待ちしております。'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :avatar, :introduction, :accepted)
  end
end
