class ReservationsController < ApplicationController

  def create

    @listing = Listing.find(params[:reservation][:listing_id])
    @reservation = @listing.reservations.new(reservation_params)

    @reservation[:payment_amount] = ((@listing.price_per_night)*(@reservation.check_out - @reservation.check_in).to_i)


        if @reservation.save

          @user = @reservation.host
          redirect_to braintree_new_path(@reservation.id)

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
