class Error < StandardError
	attr_reader :error
	attr_reader :error_message
	def initialize( error, error_message )
		super "#{error}: #{error_message}"
		@error = error
		@error_message = error_message
	end

	def as_http_hash
		{
			exception: self,
			status: http_status_code
		}
	end

	def http_status_code
		400
	end
end