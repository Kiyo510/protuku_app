class AddDefaultToUsersAdmin < ActiveRecord::Migration[6.0]
  # db:migrateした時に実行される処理
  def up
    change_column_default(:users, :admin, false)
  end

  # db:rollbackした時に実行される処理
  def down
    change_column_default(:users, :admin, nil)
  end

end
