require 'rails_helper'

RSpec.describe ForbiddenError do
	let( :error_type ) { "forbidden" }
	let( :error_message ) { "error_message" }
	let( :error ) { ForbiddenError.new error_type, error_message }

	context 'new ForbiddenError' do
		it {
			expect( error.http_status_code ).to eq 403
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