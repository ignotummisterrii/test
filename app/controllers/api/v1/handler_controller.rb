class Api::V1::HandlerController < ActionController::Base
	
	#get /show
	def show	
		@vehicles = Vehicle.all.to_json(methods: [:last_way_point])
		render :show
	end

	#post /api/v1/gps
	def gps
		WayPointVehicle.perform_async(params[:latitude], params[:longitude] , params[:sent_at] , params[:vehicle_identifier])
		render text: 'waypoints process'
	end

	
end
