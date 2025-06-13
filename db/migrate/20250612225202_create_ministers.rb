class CreateMinisters < ActiveRecord::Migration[8.0]
  def change
    create_table :ministers do |t|
      t.references :government, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.integer :order_of_precedence, null: false
      t.string :person_short_honorific, null: false
      t.timestamp :started_at, null: false
      t.timestamp :ended_at, null: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :title, null: false
      t.string :avatar_url, null: true
      t.string :role, null: false

      t.timestamps
    end
  end
end
