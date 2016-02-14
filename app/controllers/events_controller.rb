class EventsController < ApplicationController

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

  def update

    @event = Event.find(params[:id])

    @event.update({
      name: params[:name],
      description: params[:description], 
      date: params[:date], 
      reminder: params[:reminder], 
      important_person_id: params[:important_person_id]})

  end

  def destroy

    @event = Event.find(params[:id])
    @event.destroy

    redirect_to "/important_persons/#{@important_persons.id}"

  end

end
