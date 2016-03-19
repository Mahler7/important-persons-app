class EventsController < ApplicationController

  before_action :authenticate_user
  def index

    @events = current_user.events.order(:date)
    
  end

  def new

    @important_person = ImportantPerson.find_by(id: params[:important_person_id])
    @event = Event.find_by(id: params[:important_person_id])
    @user = current_user.important_persons


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
    @important_person = ImportantPerson.find_by(id: params[:important_person_id])
    @important_persons = ImportantPerson.all

  end

  def edit

    @event = Event.find(params[:id])
    @important_person = ImportantPerson.find_by(id: @event.important_person.id)
    @user = current_user.important_persons

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
