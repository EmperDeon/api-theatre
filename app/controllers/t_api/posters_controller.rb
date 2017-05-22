module TApi
  class PostersController < ApiResourceController
    MODEL_CLASS = ::Poster

    def index
      @models = Poster.by_theatre(@current_user.theatre_id).order(date: :desc).includes(:t_perf)
    end

    def create_action
      poster = Poster.create!(post_params)

      price = JSON.parse(params[:price] || '{}')

      seats = 'INSERT INTO seats(poster_id, seat, price, sell) VALUES'
      price['seats'].each {|k, v|
        seats += "(#{poster.id}, '#{k}', #{v}, 0),"
      }

      ActiveRecord::Base.connection.execute(seats[0..-2])
    end

    def update_action
      @model.update!(post_params)

      price = JSON.parse(params[:price] || '{}')

      ActiveRecord::Base.connection.execute('DELETE FROM seats WHERE poster_id = ' + @model.id.to_s)

      seats = 'INSERT INTO seats(poster_id, seat, price) VALUES'
      price['seats'].each {|k, v|
        seats += "(#{@model.id}, '#{k}', #{v}),"
      }

      ActiveRecord::Base.connection.execute(seats[0..-2])
    end
  end
end
