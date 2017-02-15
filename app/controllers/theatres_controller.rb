class TheatresController < ResourceController
    MODEL_CLASS = ::Theatre

    # noinspection RailsChecklist01
    def create_action
        t = Theatre.create!(post_params)

        halls = JSON.parse (params[:t_halls] ||= '[]')

        halls.each { |name|
            THall.create!(name: name, theatre_id: t.id, json: '{}')
        }
    end

    def update_action
        @model.update!(post_params)

        halls = JSON.parse (params[:t_halls_new] ||= '[]')
        halls.each { |name|
            THall.create!(name: name, theatre_id: t.id, json: '{}')
        }

        halls = JSON.parse (params[:t_halls_del] ||= '[]')
        halls.each { |id|
            THall.destroy(id)
        }
    end
end
