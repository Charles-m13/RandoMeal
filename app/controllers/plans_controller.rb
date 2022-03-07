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
              # print_media_type: true        # Passes `--print-media-type`
              # no_background: true           # Passes `--no-background`
      end
    end
  end

  def show
    @recipes = Recipe.order('RANDOM()').limit(5)
  end

  def new
  end

  def edit
  end

  def create
    # @plan = Plan.new(plan_params)
    # @plan.save
    # redirect_to plan_path(@plan)
  end

  def update
  end

  def save
  end

  def destroy
  end

  private

  def plan_params
    # params.require(:plan).permit(:name)
    # params.require(:recipe).permit(:name, :image, :url_marmiton, :price, :prep_duration, :total_duration, :people)
    # params.require(:ingredient).permit(:name, :quantity, :mesurement, :recipe_id)
    # params.require(:tag).permit(:name, :marmiton_filter)
  end
end
