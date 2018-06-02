class Api::V1::PasswordsController < Devise::PasswordsController
	include ApiHandlers

	def forgot_password
		User.find(params[:user_id]).send_reset_password_instructions
		render_successful_empty_response
	end

	def update
		self.resource = resource_class.reset_password_by_token(resource_params)
		if resource.errors.empty?
			render_successful_empty_response
		else
			raise Error.new 'invalid_params', resource.errors
		end
	end
end
