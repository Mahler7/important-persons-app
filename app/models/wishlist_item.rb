class WishlistItem < ActiveRecord::Base
  has_many :items
end
