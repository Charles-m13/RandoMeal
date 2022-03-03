class PagesController < ApplicationController
  def home
    @recipe = Recipe.first
  end
end
