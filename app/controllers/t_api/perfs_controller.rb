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

        end

        def approve
            v = params[:state]
            if v
                if v == '0'
                    v = 0
                elsif v == '1'
                    v = @current_user.theatre_id
                else
                    v = -1
                end

                @model.update!(approved: v)
            end

            res 'approve_ok', :ok
        end
    end
end