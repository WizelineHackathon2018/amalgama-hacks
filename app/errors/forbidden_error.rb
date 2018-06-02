class ForbiddenError < Error
	def http_status_code
		403
	end
end
