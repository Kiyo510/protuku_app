class AddContentToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :content, :text
  end
end
