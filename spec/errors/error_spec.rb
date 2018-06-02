require 'rails_helper'

RSpec.describe Error do
	let( :error_type ) { "error" }
	let( :error_message ) { "error_message" }
	let( :error ) { Error.new error_type, error_message }

	context 'new Error' do
		it {
			expect( error.http_status_code ).to eq 400
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