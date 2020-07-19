class PurchaseHistoriesController < ApplicationController
  def index
    purchase_items = PurchaseHistory. get_purchase_items(current_user)
    @purchase_items = Kaminari.paginate_array(purchase_items).page(params[:page]).per(10)
  end
end
