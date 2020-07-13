class CreateAccessControls < ActiveRecord::Migration[5.2]
  def change
    create_table :access_controls do |t|
      t.string :user_first_name
      t.string :user_last_name
      t.string :key_code
      t.string :access_level

      t.timestamps
    end
  end
end
