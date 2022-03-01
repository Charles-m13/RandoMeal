class CreateRecipeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_tags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
