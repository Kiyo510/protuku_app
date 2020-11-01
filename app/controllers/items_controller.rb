class ItemsController < ApplicationController
  include SetRoom
  before_action :authenticate_user, only: %i[show new edit update]
  before_action :ensure_correct_user, only: %i[edit update]
  layout 'btn_feedback_class_none', only: %i[new edit]

  def index
    if params[:search].present?
      items = Item.items_serach(params[:search])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      items = @tag.items.order(created_at: :desc)
    else
      items = Item.includes(:user).order('created_at DESC')
    end
    @tag_lists = Tag.all
    @items = Kaminari.paginate_array(items).page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    tag_list = params[:item][:tag_name].split(nil)
    @item.image.attach(params[:item][:image])
    @item.user_id = current_user.id
    if @item.save
      @item.save_items(tag_list)
      redirect_to items_path
    else
      flash.now[:danger] = '投稿に失敗しました'
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    # Entryモデルからメッセージ相手のレコードを抽出
    @another_entry = Entry.where(user_id: @item.user_id)
    unless @item.user_id == current_user.id
      set_room
    end
  end

  def edit
    @item = Item.find(params[:id])
    @tag_list = @item.tags.pluck(:tag_name).join(' ')
  end

  def update
    @item = Item.find(params[:id])
    @item.image.attach(params[:item][:image])
    tag_list = params[:item][:tag_name].split(nil)
    if @item.update(item_params)
      @item.save_items(tag_list)
      flash[:success] = '内容を更新しました'
      redirect_to items_path
    else
      render 'edit'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = '投稿を削除しました'
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :content, :price, :prefecture_id, :image)
  end

  def ensure_correct_user
    @item = Item.find(params[:id])
    redirect_to items_path if @item.user_id != current_user.id
  end
end
