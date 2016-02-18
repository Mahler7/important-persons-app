class EventsController < ApplicationController

  def index

    @events = Event.all
    @events = Event.order(:date)
    
  end

  def new

    @important_person = ImportantPerson.find_by(id: params[:important_person_id])

  end

  def create

    @event = Event.create({
      name: params[:name], 
      description: params[:description], 
      date: params[:event][:date], 
      reminder: params[:event][:reminder], 
      important_person_id: params[:important_person_id]})

    redirect_to "/events/#{@event.id}"

  end

  def show

    @event = Event.find_by(id: params[:id])
    @image = @event.important_person.image_url

  end

  def edit

    @event = Event.find(params[:id])
    @important_person = ImportantPerson.find_by(id: @event.important_person.id)

  end

  def update

    @event = Event.find(params[:id])

    @event.update({
      name: params[:name],
      description: params[:description], 
      date: params[:event][:date], 
      reminder: params[:event][:reminder], 
      important_person_id: params[:important_person_id]})

    render :show

  end

  def destroy

    @event = Event.find(params[:id])
    @event.destroy

    redirect_to "/events"

  end

end
