class PagesController < ApplicationController
  def home
    @recipes = Recipe.take(2)
  end
end
