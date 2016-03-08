# class ScheduleMessage
#   include Sidekiq::Worker
#   def perform(name, count)
#     MyWorker.perform_at(@message.scheduled_time, 'mike', 1)
#   end
# end