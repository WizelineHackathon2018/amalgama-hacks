class LogInWithFacebook < Interactor
	def self.get_user_with( auth_code:, device_token:, platform: )
		log_in_with_facebook = new(
			auth_code: auth_code, device_token: device_token, platform: platform
		)
		log_in_with_facebook.execute
	end

	def initialize( auth_code:, device_token:, platform: )
		@auth_code = auth_code
		@platform = platform
		@device_token = device_token
		@facebook_api = FacebookApi.new auth_code: auth_code, platform: @platform
	end

	def execute
		@response = facebook_api_response
		find_or_create_user if @response.present?
	end

	private

	def facebook_api_response
		@facebook_api.get_user_data
	end

	def find_or_create_user
		User.find_or_initialize_by(
			facebook_id: @response["id"]
		).tap { |user| update_user user: user }
	rescue ActiveRecord::RecordInvalid => exception
		log_error message: ( exception.message + " - User: #{email}" )
		unprocessable :user, exception.message
	end

	def log_error( message: )
		LogFacebookError.with auth_code: @auth_code, platform: @platform, error_message: message
	end

	def update_user( user: )
		user.update_attributes!(
			email: email,
			first_name: @response["first_name"],
			last_name: @response["last_name"],
			facebook_id: @response["id"],
			avatar: @response["avatar_url"]
		)
		RevokeTokensForUser.with user: user
		create_or_update_device user: user if @device_token.present? && @platform.present?
		user
	end

	def email
		@response["email"].present? ? @response["email"] : "#{@response["id"]}@change-me.com"
	end

	def create_or_update_device( user: )
		CreateOrUpdateDevice.with user: user, token: @device_token, platform: @platform
	end
end
