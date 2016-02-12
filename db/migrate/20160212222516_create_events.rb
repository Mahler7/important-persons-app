class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.datetime :reminder
      t.integer :important_person_id

      t.timestamps null: true
    end
  end
end
