class NotFoundError < Error
	def http_status_code
		404
	end
end
