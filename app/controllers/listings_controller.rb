class ListingsController < ApplicationController

  def create
byebug
    # @listing = current_user.listings.new(listing_params)
    @listing = Listing.new(listing_params)
    # @listing.user_id = params[:user_id]

      if @listing.save

        redirect_to user_listings_path

      else

        puts "Listing wasn't saved"

        redirect_to user_listings_path
      end

  end

  def new

    @listing = Listing.new

  end

  def index


    @all_listings = current_user.listings

  end

  def all

    @all_users_listings = Listing.all.paginate(page: params[:page], per_page: 5).order("created_at DESC")

  end

  def listing_params

    params.require(:listing).permit(:location, :price_per_night, :user_id)

  end

end
