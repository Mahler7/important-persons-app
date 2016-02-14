class EventsController < ApplicationController

  def new

  end

  def create

    @event = Event.create({name: params[:name], description: params[:description], date: params[:date], reminder: params[:reminder], important_person_id: params[:important_person_id]})

    redirect_to "/important_persons/#{@important_person.id}

  end

end
