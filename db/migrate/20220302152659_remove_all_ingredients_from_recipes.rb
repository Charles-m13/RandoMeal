class RemoveAllIngredientsFromRecipes < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :all_ingredients, :string
  end
end
