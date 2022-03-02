class AddAllIngredientsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :all_ingredients, :string
  end
end
