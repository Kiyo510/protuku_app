class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.integer :price
      t.integer :saler_id
      t.integer :buyer_id
      t.string :region

      t.timestamps
    end
    add_index :items, :created_at
  end
end
