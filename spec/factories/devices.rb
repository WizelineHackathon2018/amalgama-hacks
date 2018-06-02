FactoryBot.define do
	factory :device do
		sequence(:token) { |n| "dsf4354543n345#{n}" }
		platform :ios
		association :user, factory: :user

		factory :device_without_platform do
			platform nil
		end

		factory :device_without_token do
			token nil
		end

		factory :device_with_invalid_platform do
			platform 2
		end

		factory :device_without_user do
			user nil
		end

		trait :for_android do
			platform :android
		end
	end
end
