class CreateWorkFromHomes < ActiveRecord::Migration[7.1]
  def change
    create_table :work_from_homes do |t|
      t.integer :emp_id
      t.date :date
      t.integer :status

      t.timestamps
    end
  end
end
