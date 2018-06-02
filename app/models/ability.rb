class Ability
	include CanCan::Ability

	def initialize( user )
		admin_role if user.has_role? :admin
		user_role if user.has_role? :user
	end

	def admin_role
		can :manage, :all
	end

	def user_role
		cannot :manage, :all
	end
end
