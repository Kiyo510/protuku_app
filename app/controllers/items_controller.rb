class ItemsController < ApplicationController
  require 'payjp'

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.image.attach(params[:item][:image])
    @item.user_id = current_user.id
    if @item.save
      redirect_to items_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def purchase
    @item = Item.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    #カードテーブルから顧客のカード情報を引っ張る
    if card.blank?
      #登録されたカード情報がない場合カード登録画面へ遷移
      redirect_to controller: "cards", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報を取ってくる
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
      #購入履歴を保存
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
      customer: card.customer_id, #顧客ID
      currency: 'jpy' #日本円を選択
    )
    redirect_to action: 'done'#購入完了画面へ
  end

    private
      def item_params
        params.require(:item).permit(:title, :content, :price, :region, :image)
      end
end
