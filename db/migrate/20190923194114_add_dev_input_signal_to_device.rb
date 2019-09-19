class AddDevInputSignalToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :dev_input_signal, :string
  end
end
