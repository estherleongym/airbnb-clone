class AddConfirmationToReservations < ActiveRecord::Migration[5.1]
  def change

    add_column :reservations, :confirmation, :boolean, :default => true

  end
end
