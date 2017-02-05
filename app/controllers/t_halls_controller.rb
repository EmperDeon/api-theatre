class THallsController < ResourceController
    MODEL_CLASS = ::THall

    def index
        super

        if params[:preview] == 'true'
            @previews = @models.ids.collect { |id|
                get_preview_for_hall(id)
            }
        end
    end

    private
    def get_preview_for_hall (id)
        ActiveSupport::Base64.encode File.binread(Rails.public_path + '/none.png')
    end
end