class Listing < ApplicationRecord

  belongs_to :user
  has_many :reservations
  mount_uploaders :images, ImageUploader

  def self.search(search)
  if search
    find(:all, :conditions => ['location LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end

end
