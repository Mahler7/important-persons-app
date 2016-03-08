class ImportantPerson < ActiveRecord::Base

  belongs_to :user

  has_many :events
  has_many :messages
  has_many :wishlist_items

  validates :first_name, presence: true
  validates :user_id, presence: true

  def full_name

    "#{first_name} #{last_name}"

  end


end
