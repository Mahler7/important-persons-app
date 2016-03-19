class ScheduleMessage
  include Sidekiq::Worker
  def perform(name, count)
    MyWorker.delay_until(@message.scheduled_time, 'mike', 1)
  end
end