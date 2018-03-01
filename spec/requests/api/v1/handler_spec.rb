require 'rails_helper'

RSpec.describe 'API', type: :request do
  let!(:vehicles) { create_list(:vehicle, 10) } 
  let(:vehicle_id) { vehicles.first.id } 
  let(:vehicle_identifier) { vehicles.first.identifier } 
  let!(:way_points) { create_list(:way_point, 10 , vehicle_id: vehicle_id, vehicle_identifier: vehicle_identifier)}

	describe 'GET /show.json' do
		before { get '/show.json'}
		context 'when  vehicles exist' do
		  it 'return vehicles' do
				expect(json).not_to be_empty
				expect(json.size).to eq(10)
			end
      it 'return vehicle most recent way point' do 
          expect(json[0]['last_way_point']['vehicle_id']).to eq(vehicle_id)
      end
      it 'return status code 200' do
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'POST /api/v1/gps' do
	
		let(:valid_attributes) do
			attributes_for(:way_point, vehicle_identifier: vehicle_identifier , vehicle_id: vehicle_id)
		end
		context 'when valid request' do
			before {post '/api/v1/gps', params: valid_attributes}
			it 'return way point process' do
				expect(json['message']).to match(/waypoints process/)
			end
		end
	end
end