module TApi
    class PostersController < ApiResourceController
        MODEL_CLASS = ::Poster

        def index
            @models = Poster.by_theatre(@current_user.theatre_id).order(date: :desc).includes(:t_perf)
        end

        def create_action
	        poster = Poster.find(1) #Poster.create!(post_params)

	        price = JSON.parse params[:price]

	        seats = 'INSERT INTO seats(poster_id, seat, price) VALUES'
	        price['seats'].each { |k, v|
		        seats += "(#{poster.id}, '#{k}', #{v}),"
	        }

	        ActiveRecord::Base.connection.execute(seats[0..-2])
        end

        def update_action
            Poster.update!(post_params)
        end
    end
end
