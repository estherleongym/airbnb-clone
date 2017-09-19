class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|

      t.string :location
      t.integer :price_per_night
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
