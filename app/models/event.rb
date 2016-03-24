class Event < ActiveRecord::Base
  
  belongs_to :important_person

  validates :important_person_id, presence: true
  validates :name, presence: true
  validates :date, presence: true
  validates :date, presence: true
  validates :reminder, presence: true

  def pretty_date

     date.strftime("%A %B %e, %Y")

  end

  def pretty_reminder

    reminder.strftime("%A %B %e %Y %I %M %p")

  end

  def reminder_time

    reminder.strftime("%l:%M %p")

  end
  
  
  def start_time

      self.date
      
  end

end
