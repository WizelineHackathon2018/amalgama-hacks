class PostulantSerializer < ActiveModel::Serializer
	attributes :id, :name, :availability, :english, :gender
end
