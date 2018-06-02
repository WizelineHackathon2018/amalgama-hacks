class LogOutUser < Interactor
	def self.with( token:, tokens_controller: )
		log_out_user = new token: token, tokens_controller: tokens_controller
		log_out_user.execute
	end

	def initialize( token:, tokens_controller: )
		@token = token
		@tokens_controller = tokens_controller
		@access_token = access_token
	end

	def execute
		validate
		log_out
	end

	private

	def validate
		validate_token
		validate_tokens_controller
	end

	def user
		User.find @access_token.resource_owner_id
	end

	def log_out
		user&.device&.destroy!
		@tokens_controller.revoke_user_token
	end

	def access_token
		Doorkeeper::AccessToken.find_by token: @token
	end

	def access_token_revoked?
		@access_token.revoked_at.nil?
	end

	def validate_token
		invalid :parameters, 'The token parameter must not be null' if @token.nil?
		invalid :access_token, 'The access token doesn\'t exist' if @access_token.nil?
		forbidden :token, 'The token is already revoked' unless access_token_revoked?
	end

	def validate_tokens_controller
		invalid :tokens_controller, 'The tokens controller must not be null' if @tokens_controller.nil?
	end
end
