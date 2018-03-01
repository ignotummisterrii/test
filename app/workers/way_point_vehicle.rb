class WayPointVehicle
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform(latitude, longitude, sent_at, vehicle_identifier)
		Vehicle.find_or_create_by(identifier: vehicle_identifier).way_points.create(latitude: latitude, longitude: longitude, sent_at: sent_at, vehicle_identifier: vehicle_identifier)
	end
end