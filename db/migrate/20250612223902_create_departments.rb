class CreateDepartments < ActiveRecord::Migration[8.0]
  def change
    create_table :departments do |t|
      t.references :government, null: false, foreign_key: true
      t.string :slug, null: false, index: true
      t.string :official_name, null: false
      t.string :display_name, null: false
      t.integer :priority, null: false

      t.timestamps
    end
  end
end
