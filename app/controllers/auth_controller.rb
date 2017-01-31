class AuthController < ApplicationController
    # Filters
    before_action :check_api_token, only: [:api_check, :api_perms]
    before_action :check_web_token, only: :web_check


    #
    # Api Authentication
    #  auth - get new token
    #  check - check token
    #  perms - get current user permissions
    #
    def api_auth
        auth ::UApi
    end

    def api_check
        res 'OK'
    end

    def api_perms
        res @current_user.u_perms.collect { |h| h.perm }
    end


    #
    # Web Authentication (Mobile app)
    #  auth - get new token
    #  check - check token
    #  perms - get current user permissions
    #
    def web_auth
        auth ::UWeb
    end

    def web_check
        check_web_token
    end


    private
    #
    # Auth controller helper methods
    #

    # Authenticate user from specified model
    #  cl:: Model class object
    #
    # noinspection RubyResolve
    def auth(cl)
        user = cl.find_by_login(params[:login])
        if user.try(:authenticate, params[:pass])
            res payload(user)
        else
            err 'invalid_credentials', 'Invalid Username/Password', :unauthorized
        end
    end

    # Encode User data to JWT token
    #  user:: User object
    #
    def payload(user)
        return nil unless user and user.id
        {
            auth_token: JsonWebToken.encode({user_id: user.id, login: user.login}),
            user: {login: user.login, fio: user.fio}
        }
    end
end
