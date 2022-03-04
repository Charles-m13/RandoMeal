require 'json'
require 'nokogiri'
require 'open-uri'

Tag.destroy_all
Recipe.destroy_all
Ingredient.destroy_all

puts 'Creating seeds...'

urls = [

        "https://www.marmiton.org/recettes/recette_lasagnes-a-la-bolognaise_18215.aspx",
        "https://www.marmiton.org/recettes/recette_poulet-roti-et-ses-pommes-de-terre_43958.aspx",
        "https://www.marmiton.org/recettes/recette_hachis-parmentier_17639.aspx",
        "https://www.marmiton.org/recettes/recette_nouilles-chinoises-aux-legumes_67540.aspx",
        "https://www.marmiton.org/recettes/recette_rougail-saucisse_22851.aspx",
        "https://www.marmiton.org/recettes/recette_risotto-aux-champignons_312215.aspx",
        "https://www.marmiton.org/recettes/recette_paves-de-saumon-au-four-facile_80135.aspx",
        "https://www.marmiton.org/recettes/recette_tagliatelles-au-saumon-frais_11354.aspx",
        "https://www.marmiton.org/recettes/recette_tomates-farcies-facile_63622.aspx",
        "https://www.marmiton.org/recettes/recette_riz-cantonais-facile_27686.aspx",
        "https://www.marmiton.org/recettes/recette_saute-de-porc-a-la-creme-de-moutarde_173829.aspx",
        "https://www.marmiton.org/recettes/recette_poulet-au-coco-et-curry_17803.aspx",
        "https://www.marmiton.org/recettes/recette_gratin-de-pates-moelleux-facile-et-pas-cher_53247.aspx",
        "https://www.marmiton.org/recettes/recette_poulet-curry-et-oignons-facile_13026.aspx",
        "https://www.marmiton.org/recettes/recette_fajitas-au-poulet_26631.aspx",
        "https://www.marmiton.org/recettes/recette_oeufs-brouilles-nature_30569.aspx",
        "https://www.marmiton.org/recettes/recette_lasagnes-au-saumon-et-aux-epinards_14665.aspx",
        "https://www.marmiton.org/recettes/recette_pad-thai_11946.aspx",
        "https://www.marmiton.org/recettes/recette_spaghetti-bolognaise_19840.aspx",
        "https://www.marmiton.org/recettes/recette_parmentier-de-confit-de-canard_17048.aspx",
        "https://www.marmiton.org/recettes/recette_porc-caramel_72335.aspx",
        "https://www.marmiton.org/recettes/recette_escalopes-milanaises-comme-en-italie_55750.aspx",
        "https://www.marmiton.org/recettes/recette_cotes-de-porc-au-curry-et-au-miel_39173.aspx",
        "https://www.marmiton.org/recettes/recette_escalopes-de-veau-a-la-creme_27618.aspx",
        "https://www.marmiton.org/recettes/recette_tagliatelles-a-la-carbonara_12993.aspx",
        "https://www.marmiton.org/recettes/recette_poivrons-farcis_94368.aspx",
        "https://www.marmiton.org/recettes/recette_poulet-tandoori-masala_83513.aspx",
        "https://www.marmiton.org/recettes/recette_tartiflette-facile_15733.aspx",
        "https://www.marmiton.org/recettes/recette_risotto-au-chorizo_17724.aspx",
        "https://www.marmiton.org/recettes/recette_mac-and-cheese-super-rapide_528915.aspx",
        "https://www.marmiton.org/recettes/recette_cabillaud-au-four_44399.aspx",
        "https://www.marmiton.org/recettes/recette_cassolettes-de-saint-jacques_36866.aspx"
]

urls_vegetarien = [

                  "https://www.marmiton.org/recettes/recette_lasagnes-vegetariennes-facile_10527.aspx",
                  "https://www.marmiton.org/recettes/recette_curry-d-aubergines-au-lait-de-coco_528576.aspx",
                  "https://www.marmiton.org/recettes/recette_burger-vegetarien-aux-lentilles_345408.aspx",
                  "https://www.marmiton.org/recettes/recette_dahl-de-lentilles-corail_166862.aspx",
                  "https://www.marmiton.org/recettes/recette_aubergines-a-la-parmigiana_36293.aspx",
                  "https://www.marmiton.org/recettes/recette_aubergines-au-four_13572.aspx",
                  "https://www.marmiton.org/recettes/recette_poelee-de-legumes-d-automne_63830.aspx",
                  "https://www.marmiton.org/recettes/recette_poelee-de-courgettes-et-champignons-persilles_47002.aspx",
                  "https://www.marmiton.org/recettes/recette_galettes-de-pommes-de-terre-d-alsace_11830.aspx",
                  "https://www.marmiton.org/recettes/recette_curry-d-aubergines-au-lait-de-coco_528576.aspx",
                  "https://www.marmiton.org/recettes/recette_aiguillettes-de-poulet-au-curry-et-patates-douces_315257.aspx",
                  "https://www.marmiton.org/recettes/recette_aubergines-grillees-a-l-italienne_530509.aspx",
                  "https://www.marmiton.org/recettes/recette_poelee-de-courgettes-et-pommes-de-terres_39133.aspx",
                  "https://www.marmiton.org/recettes/recette_curry-de-chou-fleur-aux-pois-chiches_217221.aspx",
                  "https://www.marmiton.org/recettes/recette_aubergines-a-la-parmigiana_36293.aspx",
                  "https://www.marmiton.org/recettes/recette_poelee-de-legumes_168934.aspx",
                  "https://www.marmiton.org/recettes/recette_curry-de-legumes-vegetarien_88522.aspx",
                  "https://www.marmiton.org/recettes/recette_aubergines-au-four-a-la-mozzarella_50402.aspx",
                  "https://www.marmiton.org/recettes/recette_poelee-au-tofu_336944.aspx",
                  "https://www.marmiton.org/recettes/recette_salade-de-pois-chiches-feta-roquettes-et-olives_392150.aspx",
                  "https://www.marmiton.org/recettes/recette_wings-de-chou-fleur_531212.aspx",
                  "https://www.marmiton.org/recettes/recette_emince-vegetal-a-la-sauce-tomate_531193.aspx",
                  "https://www.marmiton.org/recettes/recette_riz-saute-aux-legumes-et-au-tofu_528167.aspx",
                  "https://www.marmiton.org/recettes/recette_aubergines-roties-yaourt-sauce-vierge-croutons_392605.aspx",
                  "https://www.marmiton.org/recettes/recette_wrap-de-tortilla-avocat-cheddar-oeufs-brouilles_530056.aspx",
                  "https://www.marmiton.org/recettes/recette_chou-fleur-a-la-flamande-au-companion_383192.aspx",
                  "https://www.marmiton.org/recettes/recette_quinoa-aux-petits-pois-et-a-la-feta_392146.aspx",
                  "https://www.marmiton.org/recettes/recette_galette-de-pommes-de-terre-facon-pizza_347192.aspx",
                  "https://www.marmiton.org/recettes/recette_meli-melo-ble-epeautre-et-fromage-de-brebis_528168.aspx",
                  "https://www.marmiton.org/recettes/recette_brochette-de-legumes-et-tofu_531186.aspx",
                  "https://www.marmiton.org/recettes/recette_curry-de-legumes-champignons-carotte-poireaux-et-patate-douce_372568.aspx",
                  "https://www.marmiton.org/recettes/recette_veggie-burger_371863.aspx"
]

urls_vegan = [

              "https://www.marmiton.org/recettes/recette_chili-vegan-au-hache-vegetal_335676.aspx",
              "https://www.marmiton.org/recettes/recette_pates-au-chou-fleur-recette-italienne_32668.aspx",
              "https://www.marmiton.org/recettes/recette_tajine-d-agneau-nappe-de-potiron-confit-recette-marocaine_48506.aspx",
              "https://www.marmiton.org/recettes/recette_beignets-de-courgettes-vegan_338374.aspx",
              "https://www.marmiton.org/recettes/recette_crumble-aux-potiron-vegan_532342.aspx",
              "https://www.marmiton.org/recettes/recette_trio-lentilles-quinoa-riz-pimente-aux-petits-legumes-vegan-et-delicieux_370682.aspx",
              "https://www.marmiton.org/recettes/recette_quiche-vegan-poireaux-tofu-bechamel_343805.aspx",
              "https://www.marmiton.org/recettes/recette_gaufres-de-legumes-vegan-sans-gluten_530191.aspx",
              "https://www.marmiton.org/recettes/recette_tarte-aux-carottes-vegan_529626.aspx",
              "https://www.marmiton.org/recettes/recette_pates-au-chou-fleur-recette-calabraise_44333.aspx",
              "https://www.marmiton.org/recettes/recette_moussaka-vegane_344883.aspx",
              "https://www.marmiton.org/recettes/recette_burritos-vegan_528300.aspx",
              "https://www.marmiton.org/recettes/recette_mac-and-cheese-vegan_392076.aspx",
              "https://www.marmiton.org/recettes/recette_calzone-feuillete-aux-legumes-du-soleil-vegan_528273.aspx",
              "https://www.marmiton.org/recettes/recette_galette-de-courgette-vegan_339523.aspx",
              "https://www.marmiton.org/recettes/recette_risotto-de-petit-epeautre-aux-champignons-vegan_531196.aspx"
]

urls_sansgluten = [

                  "https://www.marmiton.org/recettes/recette_butternut-burger-sans-gluten_340398.aspx",
                  "https://www.marmiton.org/recettes/recette_cake-jambon-olives-sans-gluten_337729.aspx",
                  "https://www.marmiton.org/recettes/recette_tarte-sans-gluten-aux-legumes-lardons-et-mozzarella_321505.aspx",
                  "https://www.marmiton.org/recettes/recette_flan-de-courgette-sans-gluten-facile_229292.aspx",
                  "https://www.marmiton.org/recettes/recette_carbonara-aux-crevettes-sans-gluten-et-sans-lactose_82431.aspx",
                  "https://www.marmiton.org/recettes/recette_lasagnes-sans-lactose-et-sans-gluten-des-cantoches_342673.aspx",
                  "https://www.marmiton.org/recettes/recette_galettes-de-legumes-sans-gluten_312637.aspx",
                  "https://www.marmiton.org/recettes/recette_limandes-panees-sans-gluten_62777.aspx",
                  "https://www.marmiton.org/recettes/recette_lasagne-vegetarienne-sans-gluten_232862.aspx",
                  "https://www.marmiton.org/recettes/recette_gratin-de-courgettes-au-canard-sans-lait-sans-gluten_61095.aspx",
                  "https://www.marmiton.org/recettes/recette_pizza-patisson-et-chorizo-sans-gluten_532917.aspx",
                  "https://www.marmiton.org/recettes/recette_gaufres-de-legumes-vegan-sans-gluten_530191.aspx"
]

urls_thermomix = [

                  "https://www.marmiton.org/recettes/recette_poulet-curry-et-oignons-facile-au-thermomix_383530.aspx",
                  "https://www.marmiton.org/recettes/recette_riz-cantonais-au-thermomix_383631.aspx",
                  "https://www.marmiton.org/recettes/recette_chou-fleur-a-la-flamande-au-cookeo_383191.aspx",
                  "https://www.marmiton.org/recettes/recette_aubergines-aux-epices-au-thermomix_382686.aspx",
                  "https://www.marmiton.org/recettes/recette_paupiettes-de-veau-au-cookeo_383446.aspx",
                  "https://www.marmiton.org/recettes/recette_ramen-au-boeuf-au-thermomix_383544.aspx",
                  "https://www.marmiton.org/recettes/recette_magrets-de-canard-au-miel-au-thermomix_383357.aspx",
                  "https://www.marmiton.org/recettes/recette_riz-cantonais-au-thermomix_383631.aspx",
                  "https://www.marmiton.org/recettes/recette_roti-de-porc-au-miel-et-a-la-moutarde-au-thermomix_383572.aspx",
                  "https://www.marmiton.org/recettes/recette_tomates-farcies-au-thermomix_326707.aspx",
                  "https://www.marmiton.org/recettes/recette_poulet-basquaise-au-thermomix_383514.aspx",
                  "https://www.marmiton.org/recettes/recette_poulet-curry-et-oignons-facile-au-thermomix_383530.aspx",
                  "https://www.marmiton.org/recettes/recette_saumon-au-thermomix_392181.aspx",
                  "https://www.marmiton.org/recettes/recette_tomates-farcies-au-thermomix_383636.aspx",
                  "https://www.marmiton.org/recettes/recette_tagiatelles-au-saumon-frais-au-thermomix_383617.aspx",
                  "https://www.marmiton.org/recettes/recette_tajine-de-poulet-a-la-marocaine-au-thermomix_383622.aspx",
                  "https://www.marmiton.org/recettes/recette_saumon-a-l-echalote-au-thermomix_383599.aspx",
                  "https://www.marmiton.org/recettes/recette_pates-carbonara-au-thermomix_383604.aspx",
                  "https://www.marmiton.org/recettes/recette_risotto-au-parmesan-et-au-jambon-au-thermomix_383558.aspx",
                  "https://www.marmiton.org/recettes/recette_quiche-sans-pate-au-thermomix_383519.aspx",
                  "https://www.marmiton.org/recettes/recette_filet-de-cabillaud-a-la-florentine-au-thermomix_383443.aspx",
                  "https://www.marmiton.org/recettes/recette_pates-aux-palourdes-au-thermomix_383423.aspx",
                  "https://www.marmiton.org/recettes/recette_osso-bucco-de-veau-au-thermomix_383385.aspx",
                  "https://www.marmiton.org/recettes/recette_paella-de-fruits-de-mer-chorizo-et-poulet-au-thermomix_383390.aspx",
                  "https://www.marmiton.org/recettes/recette_mijote-de-poulet-aux-legumes-au-thermomix_383365.aspx",
                  "https://www.marmiton.org/recettes/recette_blanc-de-poulet-aux-endives-champignon-et-lardons-au-thermomix_383315.aspx",
                  "https://www.marmiton.org/recettes/recette_courgettes-farcies-au-thermomix_383281.aspx",
                  "https://www.marmiton.org/recettes/recette_fricassee-de-dinde-aux-tomates-et-poivrons-au-thermomix_383292.aspx",
                  "https://www.marmiton.org/recettes/recette_fajitas-de-poulet-au-thermomix_383255.aspx",
                  "https://www.marmiton.org/recettes/recette_couscous-poulet-et-merguez-facile-au-thermomix_383239.aspx",
                  "https://www.marmiton.org/recettes/recette_mijote-de-boeuf-au-thermomix_383224.aspx"
]

puts "Creating tags"

vege = Tag.create!(name: "végétarien")
vegan = Tag.create!(name: "vegan")
sansgluten = Tag.create!(name: "sans gluten")
thermomix = Tag.create!(name: "thermomix")

puts ""
puts "Tags created"

puts "Creating recipes without tags"
urls.each { |url| ImportRecipe.new(url).call }

puts "Creating recipes with vegetarien tags"
urls_vegetarien.each { |url_vegetarien| ImportRecipe.new(url_vegetarien, vege).call }

puts "Creating recipes with thermomix tags"
urls_thermomix.each { |url_thermomix| ImportRecipe.new(url_thermomix, thermomix).call }

puts "Creating recipes with vegan tags"
urls_vegan.each { |url_vegan| ImportRecipe.new(url_vegan, vegan).call }

puts "Creating recipes with sans gluten tags"
urls_sansgluten.each { |url_sansgluten| ImportRecipe.new(url_sansgluten, sansgluten).call }

puts ""
puts "Finished"
