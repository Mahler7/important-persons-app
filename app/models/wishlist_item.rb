class WishlistItem < ActiveRecord::Base
  belongs_to :important_person
end
