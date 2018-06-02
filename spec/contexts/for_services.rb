RSpec.shared_context "stub facebook request" do |status|
	let( :header ) {
		{ 
			'Accept'=>'*/*',
			'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
			'Host'=>'graph.facebook.com',
			'User-Agent'=>'Ruby'
		}
	}
	let( :facebook_graph_api_url ) { "https://graph.facebook.com/v2.11/me" }
	let( :access_token ){ "?access_token=" + auth_code }
	let( :request_url ) {
		facebook_graph_api_url + access_token + "&fields=id,name,email,first_name,last_name,gender"
	}
	let( :request_image_url ){
		facebook_graph_api_url + "/picture" + access_token + "&height=180&redirect=false&width=180"
	}
	before {
		stub_request( :get, request_url ).
		with( headers: header ).
		to_return(status: status, body: response_body, headers: {})

		stub_request( :get, request_image_url ).
		with( headers: header ).
		to_return(status: status, body: response_image_body, headers: {})
	}
end
