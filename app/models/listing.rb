class Listing < ApplicationRecord

  belongs_to :user
  has_many :reservations
  mount_uploaders :images, ImageUploader

  def self.search(search)
    byebug
  if search
    return Listing.where("location = '#{search}'")
    # find(:all, :conditions => ['location LIKE ?', "%#{search}%"])
  else

     flash[:error] = "No search results"
    return Listing.all
  end
end

end
