class Api::V1::PostulantsController < Api::V1::ApiController

	def team_match
		render_successful_response Postulant.all, PostulantSerializer
	end
end
