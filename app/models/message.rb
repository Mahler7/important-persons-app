class Message < ActiveRecord::Base
  belongs_to :important_person

  validates :important_person_id, presence: true
  validates :title, presence: true
  validates :user_message, presence: true
  validates :message_format, presence: true

  def full_name

    # "#{important_person.first_name} #{important_person.last_name}"
  end
end
