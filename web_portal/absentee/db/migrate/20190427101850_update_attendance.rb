class UpdateAttendance < ActiveRecord::Migration[5.2]
  def change
    change_column :attendances, :date, :date
  end
end
