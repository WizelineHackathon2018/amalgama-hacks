class UserSerializer < ActiveModel::Serializer
	attributes :id, :email, :first_name, :last_name, :document_number, :avatar
end
