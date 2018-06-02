class UnauthorizedError < Error
	def http_status_code
		401
	end
end
