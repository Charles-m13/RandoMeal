class RemoveMesurementFromIngredients < ActiveRecord::Migration[6.1]
  def change
    remove_column :ingredients, :mesurement, :string
  end
end
