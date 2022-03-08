class PlansController < ApplicationController

  def index
    # Récolte 5 recettes de manière aléatoire
    @recipes = Recipe.order('RANDOM()').limit(5)
    cookies[:plan_recipes] = []
    cookies[:already_proposed] = @recipes.map(&:id).map(&:to_s).join(',')
  end

  def add
    ap cookies[:plan_recipes]
    @recipe = Recipe.find(params[:recipe_id])
    plan_recipes = cookies[:plan_recipes].split(',')
    plan_recipes << @recipe.id.to_s
    ap Recipe.where(id: plan_recipes).pluck(:name)
    cookies[:plan_recipes] = plan_recipes.join(',')
  end

  def remove
    @recipe = Recipe.find(params[:recipe_id])
    plan_recipes = cookies[:plan_recipes].split(',')
    plan_recipes = plan_recipes - [@recipe.id.to_s]
    ap Recipe.where(id: plan_recipes).pluck(:name)
    cookies[:plan_recipes] = plan_recipes.join(',')
  end

  def refresh
    plan_recipes = cookies[:plan_recipes].split(',')
    already_proposed = cookies[:already_proposed].split(',')
    nb = 5 - plan_recipes.length

    new_recipes = RandomRecipes.new(already_proposed, nb).call
    already_proposed += new_recipes.map(&:id)
    cookies[:already_proposed] = already_proposed.map(&:to_s).join(',')

    recipe_cards = new_recipes.map do |recipe|
      render_to_string(partial: "shared/card", locals: { recipe: recipe })
    end

    data = {recipe_cards: recipe_cards}
    render json: data
  end

  # Checkboxes du Menu
  def update
  end

  # Exporter le menu en PDF (gem WickedPdf)
  def export
    # Récolte 5 recettes de manière aléatoire
    @recipes = Recipe.order('RANDOM()').limit(5)
    # Bouton export
    @recipe = Recipe.first
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", 
        template: "plans/pdf.html.erb",
        title: 'RandoMeal, le menu de votre semaine',      # Titre de la page PDF
        page_size: "A4",                                   # Format de la page de résultat
        encoding: 'TEXT', 
        font_name: 'Arial',                                # Police d'écritures du texte
        margin: {top: 12, bottom: 12, left: 15, right: 12} # Cadrage des éléments
      end
    end
  end

  private

  # Méthode privé des Checkboxes du Menu
  def plan_params
    params.require(:tag).permit(:name)
    # params.require(:plan).permit(:name)
    # params.require(:recipe).permit(:name, :image, :url_marmiton, :price, :prep_duration, :total_duration, :people)
    # params.require(:ingredient).permit(:name, :quantity, :mesurement, :recipe_id)
  end
end