class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録が完了しました。"
      redirect_to root_path
    else
      flash.now[:denger] = 'ユーザー登録に失敗しました。'
      render 'new'
    end
  end

  def edit
  end

  def show
  end

    private
       def user_params
        params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
       end
end
