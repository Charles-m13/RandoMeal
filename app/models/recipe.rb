class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :recipe_tags
end
