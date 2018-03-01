class Api::V1::HandlerController < ActionController::Base
	
	#get /show
	def show	
		render 
	end

	#post /api/v1/gps
	def gps
		WayPointVehicle.perform_async(params[:latitude], params[:longitude] , params[:sent_at] , params[:vehicle_identifier])
		render json: []
	end

	
end
