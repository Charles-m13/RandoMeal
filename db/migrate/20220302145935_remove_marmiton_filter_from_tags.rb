class RemoveMarmitonFilterFromTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :marmiton_filter, :integer
  end
end
