module ApiHandlers
	def self.included( base )
		base.instance_eval do
			rescue_from ::StandardError, with: :render_standard_error
			rescue_from ::Error, with: :render_error
			rescue_from ::ActiveRecord::RecordNotFound, with: :render_record_not_found
			rescue_from ::ActiveRecord::RecordInvalid, with: :render_invalid_record
		end

		def render_successful_response( object, serializer = nil, options = {} )
			render_options = {}.merge options
			render_options = render_options.merge(
				{ json: object, root: "response", adapter: :json, status: 200 }
			)
			render_options = render_options.merge collection_serializer( object, serializer )
			render render_options
		end

		def render_successful_empty_response
			render_response_message hash: { status: "successful" }, status: 200
		end

		def render_failed_response( exception:, status: )
			hash = { "error": exception.error, "error_message": exception.error_message }
			render_response_message hash: hash, status: status
		end

		def render_response_message( hash:, status: )
			render json: { "response" => hash }, adapter: :json, status: status
		end

		def render_unauthorized_response( exception )
			render_error UnauthorizedError.new :unauthorized, exception.message
		end

		def render_bad_request( exception )
			render_error Error.new :error, exception.message
		end

		def render_forbidden( exception )
			render_error ForbiddenError.new :forbidden, exception.message
		end

		def render_record_not_found( exception )
			render_error NotFoundError.new :not_found, exception.message
		end

		def render_invalid_record( exception )
			render_error UnprocessableError.new :invalid_record, exception.record.errors.messages
		end

		def render_standard_error( exception )
			Raven.capture_exception( exception ) rescue nil
			render_error Error.new :error, exception.message
		end

		def render_error( exception )
			render_failed_response exception.as_http_hash
		end

		def current_user
			User.find doorkeeper_token.resource_owner_id rescue nil if doorkeeper_token
		end

		def collection_serializer( object, serializer )
			is_a_collection?( object ) ? { each_serializer: serializer } : { serializer: serializer }
		end

		def is_a_collection?( object )
			object.is_a?( Array ) || object.respond_to?( :to_ary )
		end
	end
end
