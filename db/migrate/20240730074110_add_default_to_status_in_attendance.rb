class AddDefaultToStatusInAttendance < ActiveRecord::Migration[7.1]
  def change
    change_column_default :attendances, :status, 0
  end
end
