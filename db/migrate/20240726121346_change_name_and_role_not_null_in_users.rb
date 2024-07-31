class ChangeNameAndRoleNotNullInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :role, false
  end
end
