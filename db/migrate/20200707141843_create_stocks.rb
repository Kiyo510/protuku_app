class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps

      # 同じ記事をストックできないように一意制約を追加
      t.index [:user_id, :item_id], unique: true
    end
  end
end
