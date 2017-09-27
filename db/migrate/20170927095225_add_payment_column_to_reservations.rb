class AddPaymentColumnToReservations < ActiveRecord::Migration[5.1]
  def change

    add_column :reservations, :payment, :boolean, :default => false

  end
end
