require 'rubocop/rake_task'

namespace :app do
	desc 'Generate fake users'
	names = ['Violet', 'Hazel', 'Charlotte', 'Scarlett', 'Lucy', 'Rose', 'Stella', 'Lily', 'Harper', 'Grace', 'Amelia', 'Olivia',
		'Oliver', 'Jack', 'Jacob', 'Henry', 'Noah', 'Isaac', 'Ethan', 'Oscar', 'Samuel', 'Lucas', 'Luke', 'Owen',
		'Lucy', 'Ella', 'Lily', 'Grace', 'Charlotte', 'Emma', 'Hannah', 'Rose', 'Emily', 'Ava', 'Chloe', 'Abigail']
	last_names = ['Joe', 'PeriBrusovich', 'Johnson', 'Bananinha', 'Sandy', 'Kai', 'Peri', 'Brusa', 'Browsie', 'McBanho', 'Agrimbau', 'Girod', 'Bross', 'Abade', 'Brosnan']

	task :create_postulants => :environment do
		25.times do
			name = names[rand(0..names.size)]
			last_name = last_names[rand(0..last_names.size)]
			Postulant.create!(name: "#{name} #{last_name}")
		end
	end

	task :remove_postulants => :environment do
		Postulant.destroy_all
	end

end
