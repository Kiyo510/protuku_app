class RenameAvatarColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :avatar, :profile_image_url
  end
end
