class Interactor
	include ActiveModel::Validations
	include ErrorRaiser

	attr_reader :arguments

	def initialize( arguments )
		@arguments = arguments
		validate!
	rescue ActiveModel::ValidationError => exception 
		invalid exception.model.errors.messages.keys.first, 
			exception.model.errors.messages.values.first.first
	end

	def method_missing( name, *args, **kwargs )
		return @arguments.fetch name if @arguments.key? name
	end
end