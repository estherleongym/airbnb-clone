class ReservationMailerJob < ApplicationJob
  queue_as :default

  def perform(guest, host, reservation_id)

    @user = guest
    @host = host
    @reservation = Reservation.find(reservation_id)

    ReservationMailer.booking_email(@user, @reservation.host, @reservation.id).deliver_now

  end
end
