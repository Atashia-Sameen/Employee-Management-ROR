class ChangeEmpIdToUserIdInWorkFromHome < ActiveRecord::Migration[7.1]
  def change
    rename_column :work_from_homes, :emp_id, :user_id
    remove_foreign_key :work_from_homes, column: :user_id, primary_key: :id
    add_foreign_key :work_from_homes, :users, column: :user_id
  end
end
