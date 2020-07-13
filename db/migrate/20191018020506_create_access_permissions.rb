class CreateAccessPermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :access_permissions do |t|
      t.belongs_to :access_control
      t.belongs_to :access_control_door
      t.time :sunday
      t.time :monday
      t.time :tuesday
      t.time :wednesday
      t.time :thursday
      t.time :friday
      t.time :saturday

      t.timestamps
    end
  end
end
