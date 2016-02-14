class MessagesController < ApplicationController

  def new

  end

  def create

    @message = message.create({
      message: params[:message],
      message_format: params[:message_format],
      important_person_id: params[:important_person_id]})

  end
end
