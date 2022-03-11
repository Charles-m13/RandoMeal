class PlansController < ApplicationController

  def index
    # Affiche le menu de la semaine
    @recipes = Recipe.order('RANDOM()').limit(5)

    cookies[:plan_recipes] = []
    cookies[:nb_persons] = []
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
    @recipe = Recipe.find(params[:recipe_id])

    # serialize / deserialize nb person
    nb_persons = cookies[:nb_persons].split(',')
    nb_persons << params[:nb_person].to_s
    cookies[:nb_persons] = nb_persons.join(',')

    plan_recipes = cookies[:plan_recipes].split(',')
    plan_recipes << @recipe.id.to_s
    ap Recipe.where(id: plan_recipes).pluck(:name)
    cookies[:plan_recipes] = plan_recipes.join(',')
    ap "je suis dans #{__method__}"
    ap cookies[:plan_recipes]
  end

  def remove
    # retrieving recipe from Ajax ex: recipe_id = 119
    @recipe = Recipe.find(params[:recipe_id])
    # converting cookies nb_persons into array ex: "4,4,5" => ["4", "4", "5"]
    nb_persons = cookies[:nb_persons].split(',')
    # converting cookies plan_recipes into array ex: "120,119,156" => ["120", "119", "156"]
    plan_recipes = cookies[:plan_recipes].split(',')
    # retriving the recipe index to remove in ["120", "119", "156"].index("119") => 1
    recipe_index_to_remove = plan_recipes.index(@recipe.id.to_s)
    # removing recipe in array plan_recipes => ["120", "156"]
    plan_recipes = plan_recipes - [@recipe.id.to_s]
    # removing quantity at the right index => ["4", "5"]
    nb_persons.delete_at(recipe_index_to_remove)

    ap Recipe.where(id: plan_recipes).pluck(:name)

    # inserting new cookies
    cookies[:plan_recipes] = plan_recipes.join(',')
    cookies[:nb_persons] = nb_persons.join(',')
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

  # Checkboxes du Menu
  def update
  end

  # Exporter le menu en PDF
  def export
    ap "je suis dans #{__method__}"
    ap cookies[:plan_recipes]

    # desirialization des cookies
    recipes_ids = cookies[:plan_recipes].split(',').map(&:to_i)

    @nb_persons = cookies[:nb_persons].split(',').map(&:to_i)
    ap recipes_ids
    # Affiche le menu de la semaine (aléatoire avec une limite de 5)
    @recipes = Recipe.find(recipes_ids)



    # Bouton export (gem WickedPdf)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name",
        template: "plans/pdf.html.erb",                     # Fichier de template
        title: 'RandoMeal, le menu de votre semaine',       # Titre de la page
        page_size: "A4",                                    # Format de la page
        encoding: 'TEXT',
        font_name: 'Arial',                                 # Police d'écritures
        margin: {top: 12, bottom: 12, left: 15, right: 12}  # Mise en page
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
