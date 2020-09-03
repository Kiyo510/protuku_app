class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[show edit update]
  before_action :correct_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'アカウント有効用のメールを送信しました。クリックして有効化をお願い致します。'
      redirect_to root_path
    else
      flash.now[:denger] = 'ユーザー登録に失敗しました。'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    # ストック一覧を取得
    stock_items = Stock.get_stock_items(current_user)
    @stock_items = Kaminari.paginate_array(stock_items).page(params[:page]).per(10)
    # 投稿した出品一覧を取得
    posted_items = @user.items
    @posted_items = Kaminari.paginate_array(posted_items).page(params[:page]).per(10)
    # Entryモデルからログインユーザーのレコードを抽出
    @current_entry = Entry.where(user_id: current_user.id)
    # Entryモデルからメッセージ相手のレコードを抽出
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          # ルームが存在する場合
          if current.room_id == another.room_id
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      # ルームが存在しない場合は新規作成
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.avatar.attach(params[:avatar])
    if @user.update(user_params)
      flash[:success] = 'プロフィールを編集しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :avatar)
  end

  # def set_user
  #   @user = User.find(params[:id])
  # end
end
