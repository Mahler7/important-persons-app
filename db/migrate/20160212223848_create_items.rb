class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_name
      t.string :url
      t.text :description

      t.timestamps null: true
    end
  end
end
