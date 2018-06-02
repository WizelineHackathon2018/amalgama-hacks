Doorkeeper.configure do
	orm :active_record

	resource_owner_from_credentials do |routes|
		begin
			LogInUser.with email: params[:email], password: params[:password]
		rescue Error => exception
			render_error exception.as_http_hash
		end
	end

	resource_owner_from_assertion do
		begin
			if params[:provider] == 'facebook'
				LogInWithFacebook.get_user_with(
					auth_code: params[:assertion],
					device_token: params[:device_token],
					platform: params[:platform]
				)
			end
		rescue Error => exception
			render_error exception.as_http_hash
		end
	end

	grant_flows %w(assertion password)

	access_token_expires_in nil
end

Doorkeeper.configuration.token_grant_types << 'password'
