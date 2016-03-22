class MessagesController < ApplicationController

  before_action :authenticate_user!

  def index
    
    @messages = current_user.messages.order(:important_person_id)
    
  end

  def message_select

    @important_person = ImportantPerson.find_by(id: params[:important_person_id])
    @user = current_user.important_persons
    @message_type = params[:message_type]

  end

  def new

    @important_person = ImportantPerson.find_by(id: params[:important_person_id])
    @user = current_user.important_persons
    @message_type = params[:message_format]

  end

  def create

    @message = Message.create({
      title: params[:title],
      user_message: params[:user_message],
      message_format: params[:message_format],
      email_template: params[:email_template],
      scheduled_time: Time.parse(params[:message][:scheduled_time]),
      important_person_id: params[:important_person_id]})

    if params[:message_format] == "text"
      text_later(@message)
    elsif params[:message_format] == "email"
      email_later(@message)
    end

    flash[:success] = "Message Created"

    redirect_to "/messages/#{@message.id}"

  end

  def show

    @message = Message.find(params[:id])
    @image = @message.important_person.image_url

  end

  def edit

    @message = Message.find(params[:id], params[:message_format])
    @important_person = ImportantPerson.find_by(id: params[:important_person_id])
    @user = current_user.important_persons

  end

  def update

    @message = Message.find(params[:id])

    @message.update({
      title: params[:title],
      user_message: params[:user_message],
      message_format: params[:message_format],
      email_template: params[:email_template],
      scheduled_time: Time.parse(params[:message][:scheduled_time]),
      important_person_id: params[:important_person_id]})

    flash[:success] = "Message Updated"

    if params[:message_format] == "text"
      text_later(@message)
    elsif params[:message_format] == "email"
      email_later(@message)
    end

    render :show

  end

  def destroy

    @message = Message.find(params[:id])

    @message.destroy

    flash[:warning] = "Message Deleted"

    redirect_to "/messages"

  end

  def send_email
    
    message = Message.find(params[:id])
    UserMailer.email_message(message).deliver_now
    @user = current_user.important_persons
    byebug
    render :show

  end

  def send_email_later
    message = Message.find(params[:id])
    email_later(message)
    render :show
  end

  def email_later(message)
    end_date = message.scheduled_time
    start_date = DateTime.current
    time = (end_date - start_date).to_i
    UserMailer.email_message(message).deliver_later(wait: time.seconds)
  end

  def send_text

    user_message = Message.find(params[:id])
    user_phone = current_user.phone_number
    message_sent = user_message.user_message
    important_person_phone = user_message.important_person.phone_number

    number_to_send_to = params[:number_to_send_to]

        twilio_sid = ENV["TWILIO_ACCOUNT_SID"]
        twilio_token = ENV["TWILIO_AUTH_TOKEN"]
        twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

        @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      
        message = @client.account.sms.messages.create(
          :from => "#{twilio_phone_number}",
          :to => "+1#{important_person_phone}",
          :body => "#{message_sent}",
          # US phone numbers can make use of an image as well.
          # :media_url => image_url 
        )
    
    render :show

  end

  def send_text_later

    message = Message.find(params[:id])
    text_later(message)
    render :show

  end

  def text_later(message)

    user_phone = current_user.phone_number
    message_sent = message.user_message
    important_person_phone = message.important_person.phone_number

    end_date = message.scheduled_time
    start_date = DateTime.current
    time = (end_date - start_date).to_i
    SmsJob.set(wait: time).perform_later(important_person_phone, message_sent)
    p end_date
    p start_date

  end

  def tweet

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_API_KEY"]
      config.consumer_secret = ENV["TWITTER_API_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end

    @message = Message.find(params[:id])
    @tweet = client.update(@message.user_message)
    @user = client.user("theonetruetest")

    render :show

  end

  # def facebook

  #   @graph = Koala::Facebook::API.new(ENV["FACEBOOK_API"])

  #   @profile = @graph.get_object("me")
    
  # end



end
