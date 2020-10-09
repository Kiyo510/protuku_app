class StocksController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    # 取得した記事がまだストックされていなければ
    unless @item.stocked?(current_user)
      # ログインしているユーザーを取得してparamsで渡された記事をストック
      @item.stock(current_user)
      @item.create_notification_stock!(current_user)
      respond_to do |format|
        format.html { redirect_to request.referer || root_url }
        format.js
      end
    end
  end

  def destroy
    @item = Stock.find(params[:id]).item
    # 取得した記事が既にストックされていれば
    if @item.stocked?(current_user)
      # ログインしているユーザーを取得してparamsで渡された記事のストック解除
      @item.unstock(current_user)
      respond_to do |format|
        format.html { redirect_to request.referer || root_url }
        format.js
      end
    end
  end
end
