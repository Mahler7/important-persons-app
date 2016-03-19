class MessagesController < ApplicationController

  before_action :authenticate_user

  def index
    # send_text
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
      scheduled_time: params[:message][:scheduled_time],
      important_person_id: params[:important_person_id]})

    flash[:success] = "Message Created"

    redirect_to "/messages/#{@message.id}"

  end

  def show

    @message = Message.find(params[:id])
    @image = @message.important_person.image_url
    # @time = Date.parse('2014-01-21 03:13:59 UTC').strftime('%m/%d/%Y')
    # @end_date = Date.parse(@message.scheduled_time.to_s).strftime('%m %d %Y %H %M')
    # @start_date = Date.parse(Time.now.to_s).strftime('%m %d %Y %H %M')
    # # @time = (@end_date - @start_date).to_i
    # @time = (@end_date - self.created_at)

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
      scheduled_time: params[:message][:scheduled_time],
      important_person_id: params[:important_person_id]})

    flash[:success] = "Message Updated"

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
    redirect_to(:back)

  end

  def send_email_later
    message = Message.find(params[:id])
    end_date = message.scheduled_time
    start_date = DateTime.now
    time = (end_date - start_date).to_i
    UserMailer.email_message(message).deliver_later(wait: time.seconds)
    redirect_to(:back)
    
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

    redirect_to(:back)

  end

  # def facebook

  #   @graph = Koala::Facebook::API.new(ENV["FACEBOOK_API"])

  #   @profile = @graph.get_object("me")
    
  # end

  # def send_text

  #   number_to_send_to = params[:number_to_send_to]

  #       twilio_sid = ENV["TWILIO_ACCOUNT_SID"]
  #       twilio_token = ENV["TWILIO_AUTH_TOKEN"]
  #       twilio_phone_number = ENV["TWILIO_PHONE_NUMBER"]

  #       @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      
  #       message = @client.account.sms.messages.create(
  #         :from => "#{twilio_phone_number}",
  #         :to => "+16305966292",
  #         :body => 'hi',
  #         # US phone numbers can make use of an image as well.
  #         # :media_url => image_url 
  #       )

  # end


end
