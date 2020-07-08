class ItemsController < ApplicationController

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

    private
      def item_params
        params.require(:item).permit(:title, :content, :price, :region, :image)
      end

end
