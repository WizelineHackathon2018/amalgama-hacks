class RevokeTokensForUser < Interactor
	validates :user, presence: true

	def self.with( user: )
		revoke_tokens_for_users = self.new user: user
		revoke_tokens_for_users.execute
	end

	def execute
		revoke_user_tokens
	end

	private
	def revoke_user_tokens
		Doorkeeper::AccessToken.where(
			resource_owner_id: user.id, revoked_at: nil
		).find_each do |access_token|
			access_token.update_attributes! revoked_at: Time.zone.now
		end
	end
end
