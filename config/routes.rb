Rails.application.routes.draw do

	require 'sidekiq/web'
	mount Sidekiq::Web => "/sidekiq"

	root "api/v1/handler#show"
	namespace :api do
		namespace :v1 do
			post 'gps', to: "handler#gps"
		end
	end
	
	get "show", to: "api/v1/handler#show"

end
