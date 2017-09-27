class ReservationsController < ApplicationController

  def create

byebug
    @listing = Listing.find(params[:reservation][:listing_id])
    @reservation = @listing.reservations.new(reservation_params)

      if @reservation.save

        redirect_to reservation_checkout_path(@reservation.id)
        #redirect to a confirmation page

      else

        @errors = @reservation.errors.full_messages
        redirect_to show_listing_path(@listing.id)

      end
  end


  def destroy



  end


  def reservation_params

    params.require(:reservation).permit(:host_id,:guest_id,:listing_id,:guests_count,:check_in, :check_out)

  end

end
