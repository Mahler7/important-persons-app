class ImportantPerson < ActiveRecord::Base

  belongs_to :user

  has_many :events
  has_many :messages

  has_many :wishlist_items

end
