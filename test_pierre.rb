# Conditions: 
# - Un menu est à minima de 5 recipe ( menu = 1)
# - Un menu peut également avoir un ou plusieurs tags ( = >1)


# Si l'utilisateur sélectionne un ou plusieurs filtre (tags) alors, regénération d'un menu complet
# randomMenu each do |recipes|
# if 

# Chaque jour de le semaine (lundi, mardi, mercredi, jeudi, vendredi)) correspond à une recette (exemple: lundi = 1 recette)

RandomMenu.new(without_ids, tags, number)
final_result = [] <-- # on démarre avec un tableau vide qui s'apelle final_result qu'on va remplir
ids = [] <-- # on démarre avec un tableau d'IDS vide qu'on va remplir de Recipes

# Affiche 5 menus qui correspondent aux filtres (avec ou sans)
# Parmi ces X menus, en prendre seulement 5
recipes = RandomRecipes.new(ids, [], 5).call

ids << recipes[0].id <<- # lundi
ids << recipes[1].id <<- # mardi
ids << recipes[2].id <<- # mercredi
ids << recipes[3].id <<- # jeudi
ids << recipes[4].id <<- # vendredi

final_result << recipes[1] <<- # L'utilisateur sélectionne l'ID 1 (exemple : il verrouille la recette du mardi)

# def save dans le controller
# refait un def call dans app/services/random_recipes.rb pour avoir 4 nouvelles recettes aléatoire

recipes = RandomRecipes.new(ids, [], 4).call

ids << recipes[0].id
ids << recipes[1].id
ids << recipes[2].id
ids << recipes[3].id

final_result << recipes[0] <<- # Si l'utilisateur sélectionne l'ID 0 (cette fois l'user verrouille la recette du lundi)
final_result << recipes[3] <<- # Si l'utilisateur sélectionne l'ID 3 (et il verrouille la recette du jeudi)

# def save dans le controller
# refait un def call dans app/services/random_recipes.rb

recipes = RandomRecipes.new(ids, [], 2).call

ids << recipes[0].id 
ids << recipes[1].id

# def save dans le controller
# refait un def call dans app/services/random_recipes.rb

recipes = RandomRecipes.new(ids, [], 4).call

ids << recipes[0].id
ids << recipes[1].id

# def save dans le controller
# refait un def call dans app/services/random_recipes.rb

final_result << recipes[1]
final_result << recipes[2]


# Affiche les 5 recettes sur la page Planificateur (1 menu pour 5 jours)
ap final_result.map(&:name)





