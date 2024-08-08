class AddEmpIdToAttendances < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :attendances, :employees, column: :emp_id
    add_index :attendances, :emp_id
  end
end
