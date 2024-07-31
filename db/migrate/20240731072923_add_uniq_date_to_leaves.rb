class AddUniqDateToLeaves < ActiveRecord::Migration[7.1]
  def change
    add_index :leaves, [:user_id, :date], unique: true
  end
end
