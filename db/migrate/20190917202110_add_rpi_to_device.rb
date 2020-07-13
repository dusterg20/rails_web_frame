class AddRpiToDevice < ActiveRecord::Migration[5.2]
  def change
    add_reference :devices, :rpi, foreign_key: true
  end
end
