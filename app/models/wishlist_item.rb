class WishlistItem < ActiveRecord::Base
  belongs_to :important_person

  validates :important_person_id, presence: true
  validates :item_name, presence: true
end
