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
# byebug
    if current_user.customer?
      @all_listings = current_user.listings
    elsif current_user.moderator?
      @all_listings = Listing.where(verification: "false")
    end
  end

  def all
    @all_users_listings = Listing.all.paginate(page: params[:page], per_page: 5).order("created_at DESC")
  end


  def verify
    byebug

    if current_user.moderator?
      @listing = Listing.find(params[:id])
        if @listing[:verification] == false
          Listing.update(@listing.id, verification: true)

        else
          flash[:notice] = "Property already verified."

        end
      end
      
    end

  def listing_params

    params.require(:listing).permit(:location, :price_per_night, :user_id)

  end

end
