class AddEmpIdToWorkFromHomes < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :work_from_homes, :employees, column: :emp_id
    add_index :work_from_homes, :emp_id
  end
end
