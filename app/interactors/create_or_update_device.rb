class CreateOrUpdateDevice < Interactor
	validates :user, :token, presence: true

	def self.with( user: , token: , platform: )
		device_creator = self.new user: user, token: token, platform: platform
		device_creator.execute
	end

	def execute
		validate_platform
		delete_device_from_other_user
		create_or_update_device
	end

	protected

	def delete_device_from_other_user
		device = Device.find_by_token token
		device&.destroy! if device&.user != user
	end

	def create_or_update_device
		Device.find_or_initialize_by( id: user.device&.id ).tap { |device|
			device.user = user
			device.token = token
			device.platform = platform unless platform.blank?
			device.save!
		}
	end

	def validate_platform
		invalid :platform, 'The platform provided must not be null' if platform.blank? && user&.device.nil?
	end
end
