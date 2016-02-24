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
      name: set_name, 
      description: params[:description], 
      date: params[:event][:date], 
      reminder: params[:event][:reminder], 
      important_person_id: params[:important_person_id]})


    flash[:success] = "Event Created"

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
      name: set_name,
      description: params[:description], 
      date: params[:event][:date], 
      reminder: params[:event][:reminder], 
      important_person_id: params[:important_person_id]})

    flash[:success] = "Event Updated"

    render :show

  end

  def destroy

    @event = Event.find(params[:id])
    @event.destroy

    flash[:warning] = "Event Deleted"

    redirect_to "/events"

  end

  private

  def set_name
    if params[:name] == 'Other' 
      params[:option_name]
    else
      params[:name]
    end
  end

end
