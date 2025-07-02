class CreateCanadianBuilders < ActiveRecord::Migration[8.0]
  def change
    create_table :canadian_builders do |t|
      t.string :name, null: false
      t.string :title, null: false
      t.string :location, null: false
      t.string :category, null: false
      t.text :description, null: false
      t.text :achievement, null: false
      t.string :avatar, null: false
      t.string :website
      t.string :slug, null: false
      t.references :government, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :canadian_builders, :slug, unique: true
    add_index :canadian_builders, :category
  end
end
