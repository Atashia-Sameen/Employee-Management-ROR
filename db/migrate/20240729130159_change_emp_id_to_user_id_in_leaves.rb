class ChangeEmpIdToUserIdInLeaves < ActiveRecord::Migration[7.1]
  def change
    rename_column :leaves, :emp_id, :user_id
    remove_foreign_key :leaves, column: :user_id, primary_key: :id
    add_foreign_key :leaves, :users, column: :user_id
  end
end
