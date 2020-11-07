class ChangeDataPrefectureIdToItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :prefecture_id, :integer, null: false
  end
  add_index :items, :prefecture_id
end
