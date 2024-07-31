class AddOrganizationIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :organization_id, :integer
    add_foreign_key :users, :organizations
    add_index :users, :organization_id
  end
end
