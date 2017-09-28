class AddPaymentAmountColumnToReservations < ActiveRecord::Migration[5.1]
  def change

    add_column :reservations, :payment_amount, :integer

  end
end
