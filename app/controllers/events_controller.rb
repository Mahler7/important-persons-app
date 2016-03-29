class EventsController < ApplicationController

  before_action :authenticate_user!
  
  def calendar

    @events = current_user.events

  end

  def index

    @events = current_user.events.order(:date)
    
  end

  def new

    @important_person = ImportantPerson.find_by(id: params[:important_person_id])
    @event = Event.find_by(id: params[:important_person_id])
    @user = current_user.important_persons

  end

  def create
    @event = Event.new({
    name: set_name, 
    description: params[:description], 
    date: params[:event][:date], 
    reminder: Time.parse(params[:event][:reminder]), 
    important_person_id: params[:important_person_id]})

    
    if @event.save
      send_reminder(@event)
      flash[:success] = "Event Created"
      redirect_to "/events/#{@event.id}"
    else
      flash[:warning] = "Event Was NOT Created"
      render :new
    end

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

    if @event.update({
      name: set_name,
      description: params[:description], 
      date: params[:event][:date], 
      reminder: Time.parse(params[:event][:reminder]), 
      important_person_id: params[:important_person_id]})

      send_reminder(@event)
      flash[:success] = "Event Updated"
      redirect_to "/events/#{@event.id}"
    else
      flash[:warning] = "Event Was NOT Updated"
      render :show
    end

  end

  def destroy

    @event = Event.find(params[:id])
    @event.destroy

    flash[:warning] = "Event Deleted"

    redirect_to "/events"

  end

  def reminder
    event = Event.find(params[:id])
    send_reminder(event)
    redirect_to(:back)
  end

  def send_reminder(event)
    user_phone = current_user.phone_number
    name = event.important_person.first_name
    message_sent = "This is your scheduled reminder for #{name}'s #{event.name} on #{event.pretty_date}"
    end_date = event.reminder
    start_date = DateTime.now
    time = (end_date - start_date).to_i
    SmsJob.set(wait: time.seconds).perform_later(user_phone, message_sent)
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
