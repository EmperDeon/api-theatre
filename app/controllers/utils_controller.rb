class UtilsController < ApplicationController
    def lists
        render json: THall.all
    end
end
