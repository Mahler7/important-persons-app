class WishlistItemsController < ApplicationController

  before_action :authenticate_user!

  def index
    
    @wishlist_items = current_user.wishlist_items.order(:important_person_id)

  end

  def new

    @important_person = ImportantPerson.find_by(id: params[:important_person_id])
    @user = current_user.important_persons

  end

  def create

    @wishlist_item = WishlistItem.new({
      item_name: params[:item_name],
      item_url: params[:item_url],
      image_url: params[:image_url],
      description: params[:description],
      favorite: params[:favorite] || 0,
      important_person_id: params[:important_person_id]
      })

    if @wishlist_item.save
      flash[:success] = "New Wishlist Item Created"
      redirect_to "/wishlist_items/#{@wishlist_item.id}"
    else
      flash[:warning] = "Wishlist Item Was NOT Created"
      render :new
    end

  end

  def show

    @wishlist_item = WishlistItem.find(params[:id])

  end

  def edit

    @wishlist_item = WishlistItem.find(params[:id])
    @important_person = ImportantPerson.find_by(id: @wishlist_item.important_person.id)
    @user = current_user.important_persons

  end

  def update

    @wishlist_item = WishlistItem.find(params[:id])

    if params[:favorite] == nil
      fave = false
    else
      fave = true
    end

    if @wishlist_item.update({
      item_name: params[:item_name],
      item_url: params[:item_url],
      image_url: params[:image_url],
      description: params[:description],
      favorite: fave,
      important_person_id: params[:important_person_id]
      })
      
      flash[:success] = "Wishlist Item Information Changed"
      redirect_to "/wishlist_items/#{@wishlist_item.id}"
    else
      flash[:warning] = "Wishlist Item Was NOT Changed"
      render :edit
    end

  end

  def destroy

    @wishlist_item = WishlistItem.find(params[:id])
    @wishlist_item.destroy

    flash[:warning] = "Wishlist Item Deleted"

    redirect_to "/wishlist_items"

  end

end
