class AddEmpIdToLeaves < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :leaves, :employees, column: :emp_id
    add_index :leaves, :emp_id
  end
end
