class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.references :klass, foreign_key: true
      t.string :name, limit: 1

      t.timestamps
    end
  end
end
