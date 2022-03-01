class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :image
      t.string :url_marmiton
      t.integer :price
      t.integer :prep_duration
      t.integer :total_duration
      t.integer :people

      t.timestamps
    end
  end
end
