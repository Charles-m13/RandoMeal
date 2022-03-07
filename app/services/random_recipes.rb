class RandomRecipes
  has_many :recipe_tags :recipes

  def initialize(without_ids, nb, tag = nil)
      @nb = nb
      @without_ids = without_ids
      @tag = tag
  end

  def call
    recipes = Recipe.where.not(id: @without_ids)
    recipes = recipes.joins(:tags).where(tags: {id: @tag.id}) if @tag
    recipes.sample(@nb)
  end
end
