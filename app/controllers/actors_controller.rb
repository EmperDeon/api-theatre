class ActorsController < ResourceController
    MODEL_CLASS = ::Actor

    def create_action
        a = Actor.new(post_params)
        a.theatre_id = @current_user.theatre_id
        a.save!
    end
end