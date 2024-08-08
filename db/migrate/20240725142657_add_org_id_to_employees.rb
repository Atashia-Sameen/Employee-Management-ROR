class AddOrgIdToEmployees < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :employees, :organizations, column: :org_id
    add_index :employees, :org_id
  end
end
