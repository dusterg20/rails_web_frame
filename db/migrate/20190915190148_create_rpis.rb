class CreateRpis < ActiveRecord::Migration[5.2]
  def change
    create_table :rpis do |t|
      t.string :rpi_name, limit: 30
      t.string :rpi_location, limit: 100
      t.string :rpi_ip, limit: 16

      t.timestamps
    end
    add_index :rpis, :rpi_name, unique: true
  end
end
