module TApi
	class TheatresController < ApiResourceController
		MODEL_CLASS = ::Theatre

        before_action :check_perm, only: [:create, :destroy, :restore]
        before_action :set_model, only: [:destroy, :restore]

        def show
            if @current_user && (@current_user.theatre_id.to_s == params[:id])
                @model = Theatre.find(params[:id])
            else
                check_perm
            end
        end

		# noinspection RailsChecklist01
		def create_action
			Theatre.create!(post_params)
		end

		def update_action
			if @current_user && (@current_user.theatre_id.to_s == params[:id])
				@model = Theatre.find(params[:id])
			else
				check_perm
			end

			@model.update!(post_params)
		end
	end
end
