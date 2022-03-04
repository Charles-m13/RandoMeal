# final_combinaison = []
# ids = []


tag = nil
# tag = Tag.find(101)

recipes =  RandomRecipes.new([15,16], tag, 3).call

ap recipes.map {|r| [r.id, [r.name, r.tags.pluck(:name)]]}.to_h




# ids << recipes[0]
# ids << recipes[1]
# ids << recipes[2]
# ids << recipes[3]
# ids << recipes[4]
# final_combinaison << recipes[1]
# recipes =  RandomRecipes.new(ids, [], 4).call
# ids << recipes[0]
# ids << recipes[1]
# ids << recipes[2]
# ids << recipes[3]
# final_combinaison << recipes[0]
# final_combinaison << recipes[3]
# recipes =  RandomRecipes.new(ids, [], 2).call
# ids << recipes[0]
# ids << recipes[1]
# recipes =  RandomRecipes.new(ids, [], 2).call
# ids << recipes[0]
# ids << recipes[1]
# final_combinaison << recipes[0]
# final_combinaison << recipes[1]

# ap final_combinaison
# p final_combinaison.map(&:name)



# cookies[:final_combinaison] = []
