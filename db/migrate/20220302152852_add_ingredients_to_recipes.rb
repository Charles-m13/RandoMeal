class AddIngredientsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :all_ingredients, :jsonb
  end
end
