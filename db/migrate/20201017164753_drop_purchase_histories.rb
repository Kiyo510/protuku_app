class DropPurchaseHistories < ActiveRecord::Migration[6.0]
  def change
    drop_table :purchase_histories
  end
end
