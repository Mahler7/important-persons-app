class Message < ActiveRecord::Base
  belongs_to :important_person

  validates :important_person_id, presence: true
  validates :user_message, presence: true
  validates :scheduled_time, presence: true

  def pretty_scheduled_time

    "#{scheduled_time.strftime("%A %B %e %Y %I %M %p ")}"

  end

  def message_capitalize
    
    "#{message_format.capitalize}"
    
  end
  
end
