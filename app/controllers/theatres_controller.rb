class TheatresController < ApplicationController


    def index
        res Theatre.all
    end

    def show
        res Theatre.find(params[:id])
    end


    def create
        t = Theatre.create(params.permit(:name, :desc, :img))
        res 'OK'
    end

    def update
        t = Theatre.find(params[:id])
        if t.update(params.permit(:name, :desc, :img))
            res 'OK'
        else
            err 'validation_error', t.errors, 500
        end
    end

    def delete

    end
end
