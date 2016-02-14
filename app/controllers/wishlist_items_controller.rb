class WishlistItemsController < ApplicationController

  def new

  end

  def create

    @wishlist_items = WishlistItems.create({important_person_id: params[:important_person_id],
      item_url_id: params[:item_url_id],
      favorite: params[:favorite]})

    redirect_to "/wishlist_items/#{@wishlist_items.id}"

  end

  def show

  end
end
