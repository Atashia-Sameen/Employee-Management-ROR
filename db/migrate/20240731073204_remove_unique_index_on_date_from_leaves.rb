class RemoveUniqueIndexOnDateFromLeaves < ActiveRecord::Migration[7.1]
  def change
    remove_index :leaves, name: "index_leaves_on_date" if index_exists?(:leaves, :date, unique: true)
  end
end
