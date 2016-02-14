class ImportantPersonsController < ApplicationController

  def index

    @important_persons = ImportantPerson.all

  end

  def new

  end

  def create

    @important_person = ImportantPerson.create({
      first_name: params[:first_name], 
      last_name: params[:last_name], 
      email: params[:email], 
      phone_number: params[:phone_number], 
      image_url: params[:image_url], 
      user_id: params[:user_id]})

    @event = @important_person.event

    redirect_to "/"

  end

  def show

    @important_person = ImportantPerson.find_by(id: params[:id])

  end

  def edit

    @important_person = ImportantPerson.find(params[:id])

  end


  def update

    @important_person = ImportantPerson.find(params[:id])

    @important_person.update({
      first_name: params[:first_name], 
      last_name: params[:last_name], 
      email: params[:email], 
      phone_number: params[:phone_number], 
      image_url: params[:image_url], 
      user_id: params[:user_id]})

    redirect_to "/important_persons/#{@important_person.id}"

  end

  def destroy

    @important_person = ImportantPerson.find(params[:id])
    @important_person.destroy

    redirect_to "/"

  end

end
