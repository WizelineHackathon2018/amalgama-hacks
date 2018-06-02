module ErrorRaiser
	def error( error_name, error_message, error = Error )
		raise error.new error_name, error_message
	end

	def invalid( exception_name, exception_message )
		error "invalid_#{exception_name}", exception_message
	end

	def unauthorized( exception_name, exception_message )
		error "unauthorized_#{exception_name}", exception_message, UnauthorizedError
	end

	def unprocessable( exception_name, exception_message )
		error "unprocessable_#{exception_name}", exception_message, UnprocessableError
	end

	def forbidden( exception_name, exception_message )
		error "forbidden_#{exception_name}", exception_message, ForbiddenError
	end

	def not_found( exception_name, exception_message )
		error "not_found_#{exception_name}", exception_message, NotFoundError
	end
end