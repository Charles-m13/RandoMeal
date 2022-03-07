class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy

  def name
  end
end
