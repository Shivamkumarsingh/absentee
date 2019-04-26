class CreateKlasses < ActiveRecord::Migration[5.2]
  def change
    create_table :klasses do |t|
      t.references :school, foreign_key: true
      t.integer :title

      t.timestamps
    end
  end
end
