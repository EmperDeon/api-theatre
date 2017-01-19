class TheatresController < ApplicationController


    def index
        res Theatre.all
    end

    def show
        res Theatre.find(params[:id])
    end


    def create

    end

    def update

    end

    def delete

    end
end
