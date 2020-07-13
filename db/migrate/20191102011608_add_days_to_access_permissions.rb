class AddDaysToAccessPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :access_permissions, :sunday_end, :time
    add_column :access_permissions, :monday_end, :time
    add_column :access_permissions, :tuesday_end, :time
    add_column :access_permissions, :wednesday_end, :time
    add_column :access_permissions, :thursday_end, :time
    add_column :access_permissions, :friday_end, :time
    add_column :access_permissions, :saturday_end, :time
  end
end
