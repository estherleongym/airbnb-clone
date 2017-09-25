class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|

      t.integer :host_id
      t.integer :guest_id
      t.references :listing, foreign_key: true
      t.integer :guests_count
      t.date :check_in
      t.date :check_out

      t.timestamps

    end
  end
end
