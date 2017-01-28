class PostersController < ResourceController
    MODEL_CLASS = ::Poster

    def index
        @models = Poster.by_theatre(@current_user.theatre_id).order(date: :desc).includes(:t_perf, :t_hall)
    end

    def create_action
        Poster.create!(post_params)
    end

    def update_action
        Poster.update!(post_params)
    end
end
