class Reservation < ApplicationRecord

  belongs_to :host, class_name: "User", foreign_key: "host_id"
  belongs_to :guest, class_name: "User", foreign_key: "guest_id"
  belongs_to :listing

  validate :check_overlapping_dates, on: :create
  # validate :guests_count_negative
  validate :start_date_after_today, on: :create
  # validate :check_max_guests

  def check_overlapping_dates

    @listing = Listing.find(self.listing_id)

    @listing.reservations.each do |existing_reservation|

      if overlap?(self, existing_reservation)

        return errors.add(:overlapping_dates, "Sorry, this listing is not available during your specified dates")


      end
    end
  end

  def overlap?(x,y)

    (x.check_in - y.check_out) * (y.check_in - x.check_out)>0

  end


  def start_date_after_today

    if self.check_in.past?
      return false
    else
      return true
    end
  end

end
