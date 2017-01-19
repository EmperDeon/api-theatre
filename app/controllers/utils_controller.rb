class UtilsController < ApplicationController
    before_action :check_api_token

    def lists
        res logged_in: 'true'
    end

    def updates

    end
end
