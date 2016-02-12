class CreateWishlistItems < ActiveRecord::Migration
  def change
    create_table :wishlist_items do |t|
      t.integer :important_person_id
      t.integer :item_url_id
      t.boolean :favorite, default: false

      t.timestamps null: false
    end
  end
end
