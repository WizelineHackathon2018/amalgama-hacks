if Rails.env.development?
	puts "creating Password..."
	password = 'password'

	puts "creating Users..."
	15.times do |n|
		first_name = "user#{n+1}"
		last_name = "user#{n+1}"
		email = "#{first_name}@example.com"
		user = User.create(
			email: email,
			password: password,
			password_confirmation: password,
			first_name: first_name,
			last_name: last_name
		)
		user.add_role :user
	end

	unless User.find_by( email: 'admin@example.com' ).present?
		admin_user = User.create!(
				email: 'admin@example.com',
				password: 'password',
				password_confirmation: 'password'
			)
		admin_user.add_role :admin
	end
end
