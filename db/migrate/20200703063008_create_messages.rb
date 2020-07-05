class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.bigint :room_id, null: false
      t.bigint :send_user_id, null: false

      t.timestamps
    end
    add_foreign_key :messages, :users, column: :room_id
    add_foreign_key :messages, :users, column: :send_user_id
  end
end
