class PlansController < ApplicationController

  def index
    @plans = Plan.all
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def save
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.save

    redirect_to plan_path(@plan)
  end

  private

  def plan_params
    params.require(:plan).permit(:name)
    params.require(:recipe).permit(:name, :image, :url_marmiton, :price)
    params.require(:ingredient).permit(:name, :quantity, :mesurement)
    params.require(:tag).permit(:name)
  end

end
