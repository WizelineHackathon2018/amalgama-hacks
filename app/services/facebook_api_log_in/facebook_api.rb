require 'net/http'
require 'uri'
require 'json'
class FacebookApi
	include ErrorRaiser

	def initialize( auth_code:, platform: )
		@auth_code = auth_code
		@access_token = "?access_token=#{auth_code}"
		@platform = platform
	end

	def get_user_data
		response = get_data
		response.merge( { "avatar_url" => get_image["data"]["url"] } )
	end

	def get_data
		facebook = URI.parse(
			Settings.facebook.graph_api_url + @access_token + "&fields=id,name,email,first_name,last_name,gender"
		)
		get_response url: facebook
	end

	def get_image
		facebook_image = URI.parse(
			Settings.facebook.graph_api_url + "/picture" + @access_token + "&width=180&height=180&redirect=false"
		)
		get_response url: facebook_image
	end

	private
	def get_response( url: )
		response = Net::HTTP.get_response url
		@response_body = JSON.parse response.body
		generate_error if @response_body["error"].present?
		@response_body
	end

	def generate_error
		log_error
		error :facebook_graph_api_error, @response_body["error"]["message"]
	end

	def log_error
		LogFacebookError.with(
			auth_code: @auth_code,
			platform: @platform,
			error_message: @response_body["error"]["message"]
		)
	end
end