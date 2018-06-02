class SignUpUser < Interactor
	validates :email, :password, :password_confirmation, presence: true

	def self.with( user: , email: , password: , password_confirmation: )
		sign_up_user = new(
			user: user, email: email, password: password, password_confirmation: password_confirmation
		)
		sign_up_user.execute
	end

	def execute
		validate_password
		user.save
		if user.persisted?
			user.add_role :user
			user
		else
			invalid :sign_up, user.errors.full_messages
		end
	end

	protected

	def validate_password
		invalid :sign_up, 'Password confirmation must be valid' if password_confirmation != password
	end
end