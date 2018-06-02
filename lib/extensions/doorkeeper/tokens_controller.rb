module Extensions
	module Doorkeeper
		module TokensController
			def revoke
				LogOutUser.with token: params[:token], tokens_controller: self
				render_empty_successful
			rescue Error => exception
				render_error exception.as_http_hash
			end

			def revoke_user_token
				revoke_token if authorized?
			end

			def create
				begin
					response = strategy.authorize
					self.headers.merge! response.headers
					self.response_body = response.body.to_json
					self.status        = response.status
				# Add this 'rescue' because otherwise Doorkeeper cannot render responses in the initializer
				rescue NoMethodError => exception
				#
				rescue Doorkeeper::Errors::DoorkeeperError => e
					auth_error_hash = params[:__auth_error]
					if !auth_error_hash.blank?
						error_type = auth_error_hash.delete(:type)
						error_description = auth_error_hash.delete(:msg)
						error = get_error_response_from_exception e
						self.headers.merge!  error.headers
						self.response_body = { 
								error: "invalid_grant", 
								error_type: error_type, 
								error_description: error_description 
							}.merge( auth_error_hash ).to_json
						self.status = error.status
					else
						handle_token_exception e
					end
				end
			end

			def render_empty_successful
				render_response_message hash: { status: 'successful' }, status: 200
			end

			def render_error( exception: , status: )
				hash = { "error": exception.error, "error_message": exception.error_message }
				render_response_message hash: hash, status: status
			end

			private

			def render_response_message( hash: , status: )
				render json: { 'response' => hash }, adapter: :json, status: status
			end
		end
	end
end
