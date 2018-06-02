require 'rails_helper'

RSpec.describe UnprocessableError do
	let( :error_type ) { "forbidden" }
	let( :error_message ) { "error_message" }
	let( :error ) { UnprocessableError.new error_type, error_message }

	context 'new UnprocessableError' do
		it {
			expect( error.http_status_code ).to eq 422
		}
		it {
			expect( error.error ).to eq error_type
		}
		it {
			expect( error.error_message ).to eq error_message
		}
		it {
			expect( error.as_http_hash ).to eq(
				{
					exception: error,
					status: error.http_status_code
				}
			)
		}
	end
end