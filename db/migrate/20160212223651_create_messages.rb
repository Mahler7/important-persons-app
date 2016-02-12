class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message
      t.string :message_format
      t.text :email_template
      t.integer :important_person_id

      t.timestamps null: true
    end
  end
end
