class AddDefaultToUsersActivated < ActiveRecord::Migration[6.0]
  # db:migrateした時に実行される処理
  def up
    change_column_default(:users, :activated, false)
  end

  # db:rollbackした時に実行される処理
  def down
    change_column_default(:users, :activated, nil)
  end
end
