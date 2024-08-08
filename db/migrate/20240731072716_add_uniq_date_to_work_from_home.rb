class AddUniqDateToWorkFromHome < ActiveRecord::Migration[7.1]
  def change
    add_index :work_from_homes, [:user_id, :date], unique: true
  end
end
