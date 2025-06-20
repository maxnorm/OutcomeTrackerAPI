class CreateDepartmentPromises < ActiveRecord::Migration[8.0]
  def change
    create_table :department_promises do |t|
      t.references :department, null: false, foreign_key: true
      t.references :promise, null: false, foreign_key: true
      t.boolean :is_lead, default: false, null: false

      t.timestamps
    end
  end
end
