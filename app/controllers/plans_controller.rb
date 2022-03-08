class PlansController < ApplicationController

  def index
    # Affiche le menu de la semaine
    @recipes = Recipe.order('RANDOM()').limit(5)
    # bouton export (gem WickedPdf)
    @recipe = Recipe.first
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", template: "plans/index.html.erb"             # Excluding ".pdf" extension.
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  # Checkboxes du Menu
  def update
    if tag.update(plan_params)
      redirect_to plans_path
    else
      render :edit
    end
  end

  # Exporter le menu en PDF
  def export
    # Affiche le menu de la semaine (aléatoire avec une limite de 5)
    @recipes = Recipe.order('RANDOM()').limit(5)
    # Bouton export (gem WickedPdf)
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

  def destroy
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
