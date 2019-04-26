class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.datetime :date
      t.boolean :present
      t.references :klass, foreign_key: true
      t.references :student, foreign_key: true
      t.references :section, foreign_key: true

      t.timestamps
    end
  end
end
