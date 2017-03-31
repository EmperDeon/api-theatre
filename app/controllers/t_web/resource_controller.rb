class TWeb::ResourceController < ApplicationController
	def get
		unless params[:name]
			return err('no_name', 'No such name', 404)
		end

		@res = case params[:name]
			       when 'poster' then
				       Poster.find(params[:id])
			       when 'posters' then
				       Poster.all
			       when 't_perf' then
				       TPerformance.find(params[:id])
			       when 't_perfs' then
				       TPerformance.all
			       when 'theatre' then
				       Theatre.find(params[:id])
			       when 'theatres' then
				       Theatre.all

			       else
				       ''
		       end

		if @res == ''
			err('no_name', 'No such name', 404)

		else
			render template: 't_web/resources/' + params[:name]
		end
	end
end