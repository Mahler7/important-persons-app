class MessagesController < ApplicationController

  before_action :authenticate_user

  def index

    @messages = current_user.messages.order(:important_person_id)

  end

  def new

    @important_person = ImportantPerson.find_by(id: params[:important_person_id])
    @important_persons = ImportantPerson.all

  end

  def create

    @message = Message.create({
      title: params[:title],
      user_message: params[:user_message],
      message_format: params[:message_format],
      scheduled_time: params[:message][:scheduled_time],
      important_person_id: params[:important_person_id]})

    flash[:success] = "Message Created"

    redirect_to "/messages/#{@message.id}"

  end

  def show

    @message = Message.find(params[:id])
    @image = @message.important_person.image_url

  end

  def edit

    @message = Message.find(params[:id])
    @important_person = ImportantPerson.find_by(id: params[:important_person_id])
    @important_persons = ImportantPerson.all


  end

  def update

    @message = Message.find(params[:id])

    @message.update({
      title: params[:title],
      user_message: params[:user_message],
      message_format: params[:message_format],
      scheduled_time: params[:message][:scheduled_time],
      important_person: params[:important_person_id]})

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

    redirect_to(:back)

  end

  def send_email_later
    message = Message.find(params[:id])
    time = message.scheduled_time
    UserMailer.email_message(message).deliver_later(time)

  end


end
