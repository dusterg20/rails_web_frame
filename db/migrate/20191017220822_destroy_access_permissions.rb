class DestroyAccessPermissions < ActiveRecord::Migration[5.2]
  def change
    drop_table :access_permissions
  end
end
