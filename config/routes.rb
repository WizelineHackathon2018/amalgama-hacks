# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
	require 'sidekiq/web'
	Sidekiq::Web.use Rack::Auth::Basic do |username, password|
		ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.secrets.sedekiq_username)) &
		ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.secrets.sedekiq_password))
	end
	mount Sidekiq::Web, at: '/sidekiq'

	use_doorkeeper
	devise_for :users, ActiveAdmin::Devise.config.merge(
		skip: [:confirmations, :registrations, :unlocks]
	)
	ActiveAdmin.routes(self)

	root 'home#index'

	scope module: 'api' do
		scope '1', module: 'v1' do
			resources :users do
				patch 'update_device_token' => 'devices#update_device_token'
				devise_scope :user do
					get 'forgot_password' => 'passwords#forgot_password'
				end
			end
			
			devise_scope :user do
				post 'users/sign_up' => 'registrations#create'
				get 'reset_password' => 'passwords#new'
				get 'change_password' => 'passwords#edit'
				put 'update_user_password' => 'passwords#update'
			end

			scope :postulant do
				get 'team_match' => 'postulants#team_match'
			end

		end
	end
end
