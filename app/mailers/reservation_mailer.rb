class ReservationMailer < ApplicationMailer

  def booking_email(guest, host, reservation_id)

    @user = guest
    @host = host
    @reservation = Reservation.find(reservation_id)

    mail(to: @host.email,subject: 'Booking Confirmation')

  end


end
