module TApi
	class PerfsController < ApiResourceController
		MODEL_CLASS = ::Performance

		before_action :set_model, only: [:show, :update, :destroy, :restore, :approve]

		def index
			@models = model_class.order(id: :desc)
			if params[:del] && params[:del] == 'true'
				@models = @models.with_deleted
			end

			@models = @models.only_approved(@current_user)
		end

		def create_action

		end

		def update_action
			@model.update!(params.permit(:author, :name, :p_type_id))
		end

		def approval
			@models = Performance.where('approved > 0')
			@theatres = Theatre.all
		end

		def approve
			v = params[:approved]
			if v
				if v.to_i < 0
					v = '-1'
				end

				@model.update!({approved: v}.merge params.permit(:author, :name, :p_type_id))
			end

			res 'approve_ok', :ok
		end
	end
end