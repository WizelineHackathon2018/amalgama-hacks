FactoryBot.define do
	factory :user do
		sequence( :first_name ) { |n| "first_name-#{n}" }
		sequence( :last_name ) { |n| "last_name-#{n}" }
		sequence( :password ) { |n| "last_name-#{n}" }
		sequence( :email ) { |n| "example#{n}@example.com" }
		phone '+549115566778'
		avatar "#{Rails.root}/spec/images/favicon.png"
		sequence( :document_number ) { |n| n }
		sequence( :facebook_id ) { |n| n }
	end
end
