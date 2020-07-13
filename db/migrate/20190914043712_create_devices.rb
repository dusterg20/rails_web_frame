class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :dev_name, limit: 30
      t.string :dev_pi, limit: 30
      t.string :dev_location, limit: 50
      t.integer :dev_pin_count
      t.integer :dev_pin1
      t.integer :dev_pin2
      t.integer :dev_pin3
      t.integer :dev_pin4
      t.integer :dev_pin5
      t.boolean :dev_data
      t.string :dev_data_type, limit: 30
      t.string :dev_data_char, limit: 5

      t.timestamps
    end
    add_index :devices, :dev_name, unique: true
  end
end
