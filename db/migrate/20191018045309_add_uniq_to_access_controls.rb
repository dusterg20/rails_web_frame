class AddUniqToAccessControls < ActiveRecord::Migration[5.2]
  def change
    add_column :access_controls, :description, :string
    add_index :access_controls, :description, unique: true
    add_column :access_controls, :office_number, :string
    add_column :access_controls, :badge_holder_phone, :string
    add_column :access_controls, :badge_holder_email, :string
  end
end
