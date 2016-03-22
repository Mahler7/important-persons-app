class ImportantPersonsController < ApplicationController

  before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def home

  end

  def index

    @important_persons = current_user.important_persons.order(:last_name)
    @user = current_user

  end

  def new

  end

  def create

    @important_person = ImportantPerson.new({
      first_name: params[:first_name], 
      last_name: params[:last_name], 
      email: params[:email], 
      phone_number: params[:phone_number], 
      image_url: params[:image_url],
      user_id: current_user.id})

    ip = params[:phone_number]
    if ip.chars.first == "1" && ip.size > 9
      ip.slice![0]
      if @important_person.save
        flash[:success] = "New Person Created"
        redirect_to "/important_persons"
      else
        flash[:warning] = "New Person Was NOT Created"
        render :new
      end
    end
    p ip
  end

  def show

    @important_person = ImportantPerson.find_by(id: params[:id])
    @events = @important_person.events
    @wishlist_items = @important_person.wishlist_items
    @messages = @important_person.messages

  end

  def edit

    @important_person = ImportantPerson.find(params[:id])

  end


  def update

    @important_person = ImportantPerson.find(params[:id])

    if @important_person.update({
      first_name: params[:first_name], 
      last_name: params[:last_name], 
      email: params[:email], 
      phone_number: params[:phone_number], 
      image_url: params[:image_url],
      user_id: current_user.id})

      flash[:success] = "Person's Info Was Updated"
      redirect_to "/important_persons/#{@important_person.id}"
    else
      flash[:warning] = "Person's Info Was NOT Updated"
      render :edit
    end

  end

  def destroy

    @important_person = ImportantPerson.find(params[:id])
    @important_person.destroy

    flash[:warning] = "Person deleted"
    
    redirect_to "/"

  end

end
