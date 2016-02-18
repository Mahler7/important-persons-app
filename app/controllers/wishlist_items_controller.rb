class WishlistItemsController < ApplicationController

  def index

    @wishlist_items = WishlistItem.all

  end

  def new

    @important_person = ImportantPerson.find_by(id: params[:important_person_id])

  end

  def create

    @wishlist_item = WishlistItem.create({
      item_name: params[:item_name],
      item_url: params[:item_url],
      image_url: params[:image_url],
      description: params[:description],
      favorite: params[:favorite],
      important_person_id: params[:important_person_id]
      })

    redirect_to "/wishlist_items/#{@wishlist_items.id}"

  end

  def show

    @wishlist_item = WishlistItem.find(params[:id])

    @first_name = @wishlist_item.important_person.first_name
    @last_name = @wishlist_item.important_person.last_name
    @image = @wishlist_item.important_person.image_url

  end

  def edit

    @wishlist_item = WishlistItem.find(params[:id])
    @important_person = ImportantPerson.find_by(id: @wishlist_item.important_person.id)
    p @wishlist_item.favorite
    p '****************'

  end

  def update

    @wishlist_item = WishlistItem.find(params[:id])

    if params[:favorite] == nil
      fave = false
    else
      fave = true
    end

    @wishlist_item.update({
      item_name: params[:item_name],
      item_url: params[:item_url],
      image_url: params[:image_url],
      description: params[:description],
      favorite: fave,
      important_person_id: params[:important_person_id]
      })

    render :show

  end

  def destroy

  end

end
