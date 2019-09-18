class AddPiModelToRpis < ActiveRecord::Migration[5.2]
  def change
    add_column :rpis, :rpi_model, :string
  end
end
