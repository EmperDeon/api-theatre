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
            t = Theatre.create!(post_params)

            halls = JSON.parse (params[:t_halls] ||= '[]')

            halls.each { |name|
                THall.create!(name: name, theatre_id: t.id, json: '{}')
            }
        end

        def update_action
            if @current_user && (@current_user.theatre_id.to_s == params[:id])
                @model = Theatre.find(params[:id])
            else
                check_perm
            end

            @model.update!(post_params)

            halls = JSON.parse (params[:t_halls_new] ||= '[]')
            halls.each { |name|
                @model.t_halls.create!(name: name, theatre_id: @model.id, json: '{}')
            }

            halls = JSON.parse (params[:t_halls_del] ||= '[]')

            halls.each { |id|
                @model.t_halls.destroy(id)
            }
        end
    end
end
