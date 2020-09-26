class ItemsController < ApplicationController
  before_action :authenticate_user, only: %i[show new edit update]
  before_action :ensure_correct_user, only: %i[edit update]
  # require 'payjp'

  def index
    if params[:search].present?
      items = Item.items_serach(params[:search])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      items = @tag.items.order(created_at: :desc)
    else
      items = Item.all.order(created_at: :desc)
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
      flash.now[:alert] = '投稿に失敗しました'
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    # Entryモデルからメッセージ相手のレコードを抽出
    @another_entry = Entry.where(user_id: @item.user_id)
    unless @item.user_id == current_user.id
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
    @item = Item.find(params[:id])
    @tag_list = @item.tags.pluck(:tag_name).join(",")
  end

  def update
    @item = Item.find(params[:id])
    tag_list = params[:item][:tag_name].split(",")
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

  def purchase
    @item = Item.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    # カードテーブルから顧客のカード情報を引っ張る
    if card.blank?
      # 登録されたカード情報がない場合カード登録画面へ遷移
      redirect_to controller: 'cards', action: 'new'
    else
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      # 保管した顧客IDでpayjpから情報を取ってくる
      customer = Payjp::Customer.retrieve(card.customer_id)
      # 保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
      # 購入履歴を保存
      new_history = @item.purchase_histories.build
      new_history.user_id = current_user.id
      new_history.save
    end
  end

  def done
    @item = Item
  end

  def pay
    @item = Item.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 決済する値段
      customer: card.customer_id, # 顧客ID
      currency: 'jpy' # 日本円を選択
    )
    redirect_to action: 'done' # 購入完了画面へ
  end

  private

  def item_params
    params.require(:item).permit(:title, :content, :price, :region, :image)
  end

  def ensure_correct_user
    @item = Item.find(params[:id])
    if @item.user_id !=  current_user.id
      redirect_to items_path
    end
  end
end
