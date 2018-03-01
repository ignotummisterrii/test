class CreateWayPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :way_points do |t|
      t.float :latitude
      t.float :longitude
      t.datetime :sent_at
      t.string :vehicle_identifier
      t.references :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
