class UserIsValid < ActiveModel::Validator
	def validate( record )
		record.errors[:user_params] <<
			'The user params must not be null' if user_has_correct_params? record
	end

	def user_has_correct_params?( record )
		# Example
		record.arguments[:user]&.last_name.blank? || record.arguments[:user]&.email.blank?
	end
end
