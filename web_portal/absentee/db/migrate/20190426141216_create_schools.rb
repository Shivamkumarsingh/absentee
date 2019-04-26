class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.text :address
      t.string :phone_number, limit:12
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
