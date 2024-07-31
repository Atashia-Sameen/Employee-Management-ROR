class AddDefaultToStatusInLeave < ActiveRecord::Migration[7.1]
  def change
    change_column_default :leaves, :status, 0
  end
end
