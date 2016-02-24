class MessagesController < ApplicationController

  def index

    @messages = Message.all
    @messages = Message.order(:important_person_id)


  end

  def new

    @important_person = ImportantPerson.find_by(id: params[:important_person_id])

  end

  def create

    @message = Message.create({
      title: params[:title],
      user_message: params[:user_message],
      message_format: params[:message_format],
      important_person_id: params[:important_person_id]})

    redirect_to "/messages/#{@message.id}"

  end

  def show

    @message = Message.find(params[:id])
    @image = @message.important_person.image_url

  end

  def edit

    @message = Message.find(params[:id])
    @important_person = ImportantPerson.find_by(id: params[:important_person_id])

  end

  def update

    @message = Message.find(params[:id])

    @message.update({
      title: params[:title],
      user_message: params[:user_message],
      message_format: params[:message_format],
      important_person: params[:important_person_id]})

    render :show

  end

  def destroy

    @message = Message.find(params[:id])

    @message.destroy

    redirect_to "/messages"

  end

end
