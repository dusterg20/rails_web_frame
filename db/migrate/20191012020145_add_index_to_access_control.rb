class AddIndexToAccessControl < ActiveRecord::Migration[5.2]
  def change
    add_index :access_controls, :key_code, unique: true
  end
end
