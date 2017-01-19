class TPerfsController < ApplicationController
    before_action :check_api_token, :check_perm

    def index
        res TPerformance.all
    end

    def create
        res 'ok'
    end

    def update
        res 'ok'
    end

    def delete
        res 'ok'
    end
end
