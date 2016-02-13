class ChangeImportantPersonImageUrlToText < ActiveRecord::Migration
  def change
    change_column :important_people, :image_url, :text
  end
end
