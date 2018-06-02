class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true
	before_action :set_locale
	serialization_scope :view_context

	def set_locale
		I18n.locale = params[:locale] || I18n.default_locale
	end

	def set_admin_locale
		I18n.locale = :es
	end

	def access_denied( exception )
		redirect_to admins_root_path, alert: exception.message
	end
end
