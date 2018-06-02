class Api::V1::DevicesController < Api::V1::ApiController
	before_action :doorkeeper_authorize!

	def update_device_token
		CreateOrUpdateDevice.with(
			user: current_user, 
			token: params[:device_token], 
			platform: params[:platform]
		)
		render_successful_empty_response
	end
end