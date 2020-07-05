class RenameSendUserIdColumnToMessages < ActiveRecord::Migration[6.0]
  def change
    rename_column :messages, :send_user_id, :user_id
  end
end
