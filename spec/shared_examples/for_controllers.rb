RSpec.shared_examples 'expect json content type' do |status|
	it { expect( response.content_type ).to eq( "application/json" ) }
	it { expect( response.status ).to eq status }
end

RSpec.shared_examples 'expect successful response' do
	include_examples 'expect json content type', 200
end

RSpec.shared_examples 'expect bad request response' do
	include_examples 'expect json content type', 400
end

RSpec.shared_examples 'expect unauthorized response' do
	it { expect( response.status ).to eq 401 }
end

RSpec.shared_examples 'expect redirect response' do
	it { expect( response.status ).to eq 302 }
end

RSpec.shared_examples 'expect forbidden response' do
	include_examples 'expect json content type', 403
end

RSpec.shared_examples 'expect not found response' do
	include_examples 'expect json content type', 404
end

RSpec.shared_examples 'expect unprocessable entity response' do
	include_examples 'expect json content type', 422
end