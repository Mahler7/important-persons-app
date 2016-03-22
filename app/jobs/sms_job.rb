class SmsJob < ActiveJob::Base
  queue_as :default

  def perform(number_to, message)
    twilio_sid = ENV["TWILIO_ACCOUNT_SID"]
    twilio_token = ENV["TWILIO_AUTH_TOKEN"]
    twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    
    message = @client.account.sms.messages.create(
      :from => "#{twilio_phone_number}",
      :to => "+1#{number_to}",
      :body => "#{message}",
      # US phone numbers can make use of an image as well.
      # :media_url => image_url 
    )
  end
end
