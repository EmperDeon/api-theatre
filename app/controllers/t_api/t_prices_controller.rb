module TApi
	class TPricesController < ApiResourceController
		MODEL_CLASS = ::TPrice

		def index
			super


		end

		def create_action
			TPrice.create({theatre_id: @current_user.theatre_id, name: params[:name], json: params[:json]})
		end

	end
end
