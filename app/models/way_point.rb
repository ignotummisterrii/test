class WayPoint < ApplicationRecord
  belongs_to :vehicle
  validates_presence_of :latitude, :longitude, :sent_at, :vehicle_identifier
  
end
