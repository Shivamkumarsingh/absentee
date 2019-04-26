class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :roll_number
      t.references :klass, foreign_key: true
      t.references :section, foreign_key: true
      t.string :primary_contact_number, limit: 12
      t.string :secondary_contact_number, limit: 12

      t.timestamps
    end
  end
end
