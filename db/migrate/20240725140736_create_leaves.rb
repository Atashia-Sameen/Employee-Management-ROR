class CreateLeaves < ActiveRecord::Migration[7.1]
  def change
    create_table :leaves do |t|
      t.integer :emp_id
      t.integer :type
      t.date :date
      t.integer :status
      t.integer :manager_id

      t.timestamps
    end
  end
end
