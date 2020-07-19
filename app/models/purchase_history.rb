class PurchaseHistory < ApplicationRecord
  belongs_to :user
  belongs_to :item
  #購入履歴一覧を表示
  def self.get_purchase_items(user)
    self.where(user_id: user.id).map(&:item)
  end

end
