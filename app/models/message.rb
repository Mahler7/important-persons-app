class Message < ActiveRecord::Base
  belongs_to :important_person

  validates :important_person_id, presence: true
  validates :title, presence: true
  validates :user_message, presence: true
  validates :message_format, presence: true

  # def pretty_scheduled_time

  #   scheduled_time.strftime("%A %B %e %Y %m %M %p ")

  # end
  
end
