class CreateAccessControlDoors < ActiveRecord::Migration[5.2]
  def change
    create_table :access_control_doors do |t|
      t.string :name
      t.string :location
      t.string :description
      t.string :reader_manuf
      t.string :reader_model
      t.string :reader_serial

      t.timestamps
    end
    add_index :access_control_doors, :name
    add_index :access_control_doors, :reader_serial, unique: true
  end
end
