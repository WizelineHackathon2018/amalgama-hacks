class Api::V1::UsersController < Api::V1::ApiController
	before_action :doorkeeper_authorize!

	def show
		render_successful_response current_user, UserSerializer
	end
end
