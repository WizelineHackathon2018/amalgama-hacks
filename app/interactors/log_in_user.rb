class LogInUser < Interactor
	validates :email, :password, presence: true

	def self.with( email: , password: , device_token: , platform: )
		log_in_user = new(
			email: email, password: password, device_token: device_token, platform: platform
		)
		log_in_user.execute
	end

	def execute
		@user = User.find_for_database_authentication( :email => email )
		validate_app_user
		log_in
	end
	
	private

	def validate_app_user
		forbidden :user, "The user doesn\'t exist" unless @user.present?
		invalid :user, "The user role is invalid" unless @user.has_role? :user
	end

	def log_in
		if @user && @user.valid_for_authentication? { @user.valid_password? password }
			RevokeTokensForUser.with user: @user
			create_or_update_device user: @user unless device_token.blank? || platform.blank?
			@user
		end
	end
	
	def create_or_update_device( user: )
		CreateOrUpdateDevice.with user: user, token: device_token, platform: platform
	end
end
