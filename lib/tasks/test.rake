namespace :test do 
	desc "Load"
		task :create => :environment do
			v1 = Vehicle.find_or_create_by(identifier: "HA-3452")
			v2 = Vehicle.find_or_create_by(identifier: "XX-1258")
			v3 = Vehicle.find_or_create_by(identifier: "ZY-1122")


			
			v1.way_points.create latitude: -34.9956429 , longitude: -71.2441796 , sent_at: DateTime.parse("2018-03-01 02:01:00")  , vehicle_identifier: v1.identifier, vehicle: v1
			v1.way_points.create latitude: -34.9956429 , longitude: -71.2441792 , sent_at: DateTime.parse("2018-03-01 02:02:00")  , vehicle_identifier: v1.identifier, vehicle: v1
			v1.way_points.create latitude: -34.9956429 , longitude: -71.2441792 , sent_at: DateTime.parse("2018-03-01 02:03:00"), vehicle_identifier: v1.identifier, vehicle: v1
			v1.way_points.create latitude: -34.9913164 , longitude: -71.2461539 , sent_at: DateTime.parse("2018-03-01 02:04:00"), vehicle_identifier: v1.identifier, vehicle: v1
			v1.way_points.create latitude: -34.9926722 , longitude: -71.2400875 , sent_at: DateTime.parse("2018-03-01 02:05:00"), vehicle_identifier: v1.identifier, vehicle: v1
			v1.way_points.create latitude: -34.9897155 , longitude: -71.2387161 , sent_at: DateTime.parse("2018-03-01 02:06:00"), vehicle_identifier: v1.identifier, vehicle: v1

			v2.way_points.create latitude: -34.9937215 , longitude: -71.2372907 , sent_at: DateTime.parse("2018-03-01 01:01:00"), vehicle_identifier: v1.identifier, vehicle: v2
			v2.way_points.create latitude: -34.9937215 , longitude: -71.2372907 , sent_at: DateTime.parse("2018-03-01 01:02:00"), vehicle_identifier: v1.identifier, vehicle: v2
			v2.way_points.create latitude: -34.9897155 , longitude: -71.2372907 , sent_at: DateTime.parse("2018-03-01 01:03:00"), vehicle_identifier: v1.identifier, vehicle: v2
			v2.way_points.create latitude: -34.9937215 , longitude: -71.2372907 , sent_at: DateTime.parse("2018-03-01 01:04:00"), vehicle_identifier: v1.identifier, vehicle: v2
			v2.way_points.create latitude: -34.9897156 , longitude: -71.2372907 , sent_at: DateTime.parse("2018-03-01 01:05:00"), vehicle_identifier: v1.identifier, vehicle: v2
			v2.way_points.create latitude: -34.9897158 , longitude: -71.2372907 , sent_at: DateTime.parse("2018-03-01 01:08:00"), vehicle_identifier: v1.identifier, vehicle: v2

			v3.way_points.create latitude: -34.9907207 , longitude: -71.236984 , sent_at: DateTime.parse("2018-03-01 00:30:00"), vehicle_identifier: v1.identifier, vehicle: v3
			v3.way_points.create latitude: -34.9882225 , longitude: -71.235775 , sent_at: DateTime.parse("2018-03-01 00:31:00"), vehicle_identifier: v1.identifier, vehicle: v3
			v3.way_points.create latitude: -34.9882225 , longitude: -71.235775 , sent_at: DateTime.parse("2018-03-01 00:32:00"), vehicle_identifier: v1.identifier, vehicle: v3
			v3.way_points.create latitude: -34.9882225 , longitude: -71.235775 , sent_at: DateTime.parse("2018-03-01 00:32:00"), vehicle_identifier: v1.identifier, vehicle: v3
			v3.way_points.create latitude: -34.9897156 , longitude: -71.235779 , sent_at: DateTime.parse("2018-03-01 00:32:01"), vehicle_identifier: v1.identifier, vehicle: v3
			v3.way_points.create latitude: -34.9897158 , longitude: -71.235776 , sent_at: DateTime.parse("2018-03-01 00:32:02"), vehicle_identifier: v1.identifier, vehicle: v3



		end
end