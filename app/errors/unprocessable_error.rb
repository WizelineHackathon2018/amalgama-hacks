class UnprocessableError < Error
	def http_status_code
		422
	end
end