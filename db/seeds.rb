require 'json'
require 'nokogiri'
require 'open-uri'

Tag.destroy_all
Recipe.destroy_all
Ingredient.destroy_all

puts 'Creating seeds...'

urls = [ "https://www.marmiton.org/recettes/recette_lasagnes-a-la-bolognaise_18215.aspx",
        "https://www.marmiton.org/recettes/recette_poulet-roti-et-ses-pommes-de-terre_43958.aspx"
      ]

urls_vegetarien = ["https://www.marmiton.org/recettes/recette_lasagnes-vegetariennes-facile_10527.aspx",
  "https://www.marmiton.org/recettes/recette_curry-d-aubergines-au-lait-de-coco_528576.aspx",
  "https://www.marmiton.org/recettes/recette_burger-vegetarien-aux-lentilles_345408.aspx",
  "https://www.marmiton.org/recettes/recette_dahl-de-lentilles-corail_166862.aspx",
  "https://www.marmiton.org/recettes/recette_aubergines-a-la-parmigiana_36293.aspx"]

# urls_vegan = ""
# urls_sansgluten = ""

urls_thermomix = ["https://www.marmiton.org/recettes/recette_poulet-curry-et-oignons-facile-au-thermomix_383530.aspx",
  "https://www.marmiton.org/recettes/recette_riz-cantonais-au-thermomix_383631.aspx"
]

puts "Creating tags"

vege = Tag.create!(name: "végétarien")
vegan = Tag.create!(name: "vegan")
sans_gluten = Tag.create!(name: "sans gluten")
thermomix = Tag.create!(name: "thermomix")

puts ""
puts "Tags created"

puts "Creating recipes without tags"
urls.each {|url| ImportRecipe.new(url).call }

puts "Creating recipes without tags"
urls_vegetarien.each {|url| ImportRecipe.new(url, vege).call }

puts "Creating recipes without tags"
urls_thermomix.each {|url| ImportRecipe.new(url, thermomix).call }

# ImportRecipe.new("https://www.marmiton.org/recettes/recette_poulet-curry-et-oignons-facile-au-thermomix_383530.aspx", thermomix).call

puts ""
puts "Finished"
