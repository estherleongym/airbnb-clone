class User < ApplicationRecord
  include Clearance::User
  attr_accessor :image
  has_many :authentications, dependent: :destroy
  has_many :listings
  has_many :guest_reservations, class_name: "Reservation", foreign_key: "guest_id"
  has_many :host_reservations, class_name: "Reservation", foreign_key: "host_id"


  enum access_level: [:customer, :moderator, :superadmin]
  mount_uploader :image, ImageUploader
      def self.create_with_auth_and_hash(authentication, auth_hash)


        user = self.create!(
          first_name: auth_hash["extra"]["raw_info"]["first_name"],
          last_name: auth_hash["extra"]["raw_info"]["last_name"],
          email: auth_hash["extra"]["raw_info"]["email"],
          password: SecureRandom.hex(2)
        )
        user.authentications << authentication
        return user
      end

      # grab fb_token to access Facebook for user data
      def fb_token
        x = self.authentications.find_by(provider: 'facebook')
        return x.token unless x.nil?
      end


end
