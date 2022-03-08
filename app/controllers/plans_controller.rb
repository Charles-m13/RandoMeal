class PlansController < ApplicationController

  def index
    # Affiche le menu de la semaine
    @recipes = Recipe.order('RANDOM()').limit(5)

    cookies[:plan_recipes] = []
    cookies[:already_proposed] = @recipes.map(&:id).map(&:to_s).join(',')

    # bouton export (gem WickedPdf)
    @recipe = Recipe.first
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", template: "plans/index.html.erb"             # Excluding ".pdf" extension.
      end
    end
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

    if params[:filter].present?
      tag = Tag.find_by(name: params[:filter])
      ap tag
    end

    new_recipes = RandomRecipes.new(already_proposed, nb, tag ||= nil ).call
    ap new_recipes
    already_proposed += new_recipes.map(&:id)
    cookies[:already_proposed] = already_proposed.map(&:to_s).join(',')
    recipe_cards = new_recipes.map do |recipe|
      render_to_string(partial: "shared/card", locals: { recipe: recipe })
    end

    data = {recipe_cards: recipe_cards}
    render json: data
  end

  def export
    # Affiche le menu de la semaine
    @recipes = Recipe.order('RANDOM()').limit(5)
    # bouton export (gem WickedPdf)
    @recipe = Recipe.first
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name",
        template: "plans/pdf.html.erb",
        title: 'RandoMeal, le menu de votre semaine',
        page_size: "A4",
        encoding: 'TEXT',
        font_name: 'Arial',
        margin: {top: 12, bottom: 12, left: 15, right: 12}
      end
    end
  end
end
