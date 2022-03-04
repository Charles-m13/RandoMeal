class PlansController < ApplicationController

  def index
    @recipes = Recipe.order('RANDOM()').limit(5)
  end

  def new
  end

  def create
    # @plan = Plan.new(plan_params)
    # @plan.save
    # redirect_to plan_path(@plan)
  end

  def show
    # @plan = Plan.find(params[:id])
  end

  def save
  end

  def edit
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
