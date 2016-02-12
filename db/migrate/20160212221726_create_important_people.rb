class CreateImportantPeople < ActiveRecord::Migration
  def change
    create_table :important_people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :image_url
      t.integer :user_id

      t.timestamps null: true
    end
  end
end
