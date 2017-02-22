class UApisController < ApplicationController
    before_action :check_api_token, only: [:api_perms, :api_get_settings, :api_set_settings]

    def api_perms
        res @current_user.u_perms.collect { |h| h.perm }
    end

    def api_get_settings
        if params[:key]
            res (JSON.parse @current_user.json)[params[:key]]
        else
            res JSON.parse @current_user.json
        end

    end

    def api_set_settings
        @current_user.update!(json: (params[:settings] || '{}'))

        res 'ok'
    end
end
