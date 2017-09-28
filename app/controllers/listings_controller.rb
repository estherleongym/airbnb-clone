class ListingsController < ApplicationController

  def create
    # @listing = current_user.listings.new(listing_params)
    @listing = Listing.new(listing_params)
    # (:location => params[:listing][:location], :price_per_night => params[:listing][:price_per_night], :images => [:listing][:images])
    # @listing.user_id = params[:user_id]
      if @listing.save
        redirect_to root_path
      else
        puts "Listing wasn't saved"
        redirect_to root_path
      end
    end

  def new

    @listing = Listing.new

  end

  def show

    @listing = Listing.find(params[:id])

  end

  def index

    if current_user.customer?
      @all_listings = current_user.listings
    elsif current_user.moderator?
      @all_listings = Listing.where(verification: "false")
    elsif !(params[:search].empty?)
      @all_listings = Listing.search(params[:search])
    end
  end

  def all

    @all_users_listings = Listing.all.paginate(page: params[:page], per_page: 7).order("created_at DESC")
    redirect_to root_path

  end


  def verify

    if current_user.moderator?
      @listing = Listing.find(params[:id])
        if @listing[:verification] == false
          Listing.update(@listing.id, verification: true)

        else
          flash[:notice] = "Property already verified."

        end
      end

    end

    def search



    end


  def listing_params

    params.require(:listing).permit(:location, :price_per_night, :user_id, {images: []})

  end

end
