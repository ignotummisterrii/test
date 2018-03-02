class WayPointVehicle
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform(latitude, longitude, sent_at, vehicle_identifier)
		vehicle = Vehicle.find_by_identifier(vehicle_identifier) || Vehicle.new(identifier: vehicle_identifier)
		vehicle.way_points.new(latitude: latitude, longitude: longitude, sent_at: DateTime.parse(sent_at), vehicle_identifier: vehicle_identifier).save
	end
end