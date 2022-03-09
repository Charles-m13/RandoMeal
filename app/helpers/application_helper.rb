module ApplicationHelper

  def ingredient_displayer(recipe, nb_person)
    results = recipe.ingredients.map do |ingredient|
      [ingredient.quantity.to_i * nb_person.to_i , ingredient.name]
    end

    results.flatten.join(" ")
  end
end
