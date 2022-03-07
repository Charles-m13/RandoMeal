class RandomRecipes
  has_many :recipe_tags :recipes

  def initialize(wihtout_ids, tags, nb)
    @nb = nb
    @tags = tags
  end

  def call
    # nb = 5
    # if Tags.present?
    #   each do |recipes|.sample .5.times
    # else Tags.present
    #   each do |recipes| |tags|.sample .5.times
    # end
    # return call
  end
end

# request from js
    # vérifier combien de recettes sont déjà locked ex: 2 recettes locks
    # Initialiser le service avec 5 - 2 recettes, et excluant les ids des recettes déjà selectionnées
    # chopper une recette dans le retour du service
    # rendre la partial de cette recette
