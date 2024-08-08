class ChangeEmpIdToUserIdInAttendances < ActiveRecord::Migration[7.1]
  def change
    rename_column :attendances, :emp_id, :user_id
    remove_foreign_key :attendances, column: :user_id, primary_key: :id
    add_foreign_key :attendances, :users, column: :user_id
  end
end
