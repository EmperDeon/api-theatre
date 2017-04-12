module TApi
	class TPerfsController < ApiResourceController
		MODEL_CLASS = ::TPerformance

		# noinspection RailsChecklist01
		def create_action
			if params.has_key? :perf_new
				perf_par = JSON.parse(params[:perf_new])
				perf_par[:approved] = @current_user.theatre_id

				perf = Performance.create!(perf_par)
			else
				perf = Performance.find(params[:perf_id])
			end

			t_perf = TPerformance.new(post_params)
			t_perf.perf = perf

			JSON.parse(params['actors'] || '[]').each { |a|
				t_perf.actors << Actor::find(a)
			}

			t_perf.theatre_id = @current_user.theatre_id
			t_perf.save!
		end

		def update_action
			if params.has_key? :perf_new
				perf_par = JSON.parse(params[:perf_new])
				perf = Performance.create!(perf_par + {approved: @current_user.theatre_id})
				@model.perf = perf
			elsif params.has_key? :perf_id
				@model.perf = Performance.find(params[:perf_id])
			end

			@model.actors.clear
			JSON.parse(params['actors'] || '[]').each { |a|
				@model.actors << Actor::find(a)
			}

			@model.theatre_id = @current_user.theatre_id
			@model.update!(post_params)
		end
	end
end
