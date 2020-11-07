class ChangeColumnRegionToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :region, :prefecture_id
  end
end
