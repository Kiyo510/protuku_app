class RemoveColumnsFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :price, :integer
    remove_column :items, :saler_id, :integer
    remove_column :items, :buyer_id, :integer
  end
end
