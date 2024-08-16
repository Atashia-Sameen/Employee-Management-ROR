class RemoveManagerIdFromLeaves < ActiveRecord::Migration[7.1]
  def change
    remove_column :leaves, :manager_id
  end
end
