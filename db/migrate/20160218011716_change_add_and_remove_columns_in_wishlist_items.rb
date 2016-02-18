class ChangeAddAndRemoveColumnsInWishlistItems < ActiveRecord::Migration
  def change
    remove_column :wishlist_items, :item_url_id, :integer
    add_column :wishlist_items, :item_name, :string
    add_column :wishlist_items, :item_url, :text
    add_column :wishlist_items, :image_url, :text
    add_column :wishlist_items, :description, :text
  end
end
