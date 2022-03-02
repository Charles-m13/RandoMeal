class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :recipe_tags
end
