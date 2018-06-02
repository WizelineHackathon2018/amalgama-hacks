class LogFacebookError
	def self.with( auth_code: , platform: , error_message: )
		log_facebook_error = self.new(
			auth_code: auth_code, platform: platform, error_message: error_message
		)
		log_facebook_error.execute
	end

	def initialize( auth_code: , platform: , error_message: )
		@auth_code = auth_code
		@platform = platform
		@error_message = error_message

		@my_logger ||= Logger.new "#{Rails.root}/log/facebook_error.log"
	end

	def execute
		@my_logger.info(
			"Token: #{@auth_code} - Platform: #{@platform} - Message: #{@error_message}"
		)
	end
end