class AddDeviceToRpi < ActiveRecord::Migration[5.2]
  def change
    add_reference :rpis, :device, index: true
  end
end
