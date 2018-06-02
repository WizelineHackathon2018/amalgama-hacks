class Api::V1::RegistrationsController < Devise::RegistrationsController
	include ApiHandlers

	def create
		user = SignUpUser.with(
			user: build_resource(sign_up_params),
			email: email,
			password: password,
			password_confirmation: password_confirmation
		)
		render_successful_response sign_up( :user, user ), UserSerializer
	end

	private

	def sign_up_params
		params.require( :user ).permit :email, :password, :password_confirmation
	end

	def method_missing( name, *args, **kwargs )
		sign_up_params[ name ]
	end

	# Use this method to render if you overwrite user.active_for_authentication? in User.rb or
	# if the User has the :confirmable option available.

	# def active_for_authentication
	# 	if user.active_for_authentication?
	# 		render_successful_response sign_up( :user, user ), UserSerializer
	# 	else
	# 		expire_data_after_sign_in!
	# 		Error.new 'invalid_sign_up', "signed_up_but_#{user.inactive_message}"
	# 	end
	# end
end