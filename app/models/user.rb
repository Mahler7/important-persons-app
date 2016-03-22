class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :important_persons
  has_many :events, through: :important_persons
  has_many :wishlist_items, through: :important_persons
  has_many :messages, through: :important_persons

  validates :phone_number, numericality: true
  
end
