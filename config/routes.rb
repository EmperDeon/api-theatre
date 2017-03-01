Rails.application.routes.draw do
    scope '/auth_api' do
        match 'new', to: 'auth#api_auth', via: [:get, :post]
        post 'check', to: 'auth#api_check'

        post 'perms', to: 'u_apis#api_perms'
        post 'get_settings', to: 'u_apis#api_get_settings'
        post 'set_settings', to: 'u_apis#api_set_settings'
    end

    scope '/auth_web' do
        post 'new', to: 'auth#web_auth'
        post 'check', to: 'u_webs#web_check'
    end

    scope '/utils' do
        get 'updates', to: 'utils#updates'
        get 'lists', to: 'utils#lists' # TODO: Probably not used
        get 'hashes', to: 'utils#hashes'

        post 'upload', to: 'utils#upload'
        get 'preview', to: 'utils#preview'

        get 'deleted', to: 'utils#get_deleted'
        # get 'change', to: 'utils#change'
    end


    #
    # API routes
    #  Used by: TheatreAdmin app
    #  TODO: Maybe scope all API routes
    #

    # Generates 'CRUD' routes for specified controller
    #  Why not 'resources :name' ?
    #  Because i don't want to work with PATCH, PUT, etc. in Qt (Theatres Admin App)
    #
    # name:: Prefix for route and controller name
    def api_res (name)
        scope '/' + name + '/' do
            post '/create', as: '', to: 't_api/' + name + '#create'
            post '/update', as: '', to: 't_api/' + name + '#update'
            post '/destroy', as: '', to: 't_api/' + name + '#destroy'
            post '/restore', as: '', to: 't_api/' + name + '#restore'

            # TODO: Temporary. Delete POST in release
            match '/', as: '', to: 't_api/' + name + '#index', via: [:get, :post]
            match '/:id', as: '', to: 't_api/' + name + '#show', via: [:get, :post]
        end
    end

    post 'perfs/approval', as: '', to: 't_api/perfs#approval'
    post 'perfs/approve', as: '', to: 't_api/perfs#approve'

    api_res 'articles'
    api_res 'actors'
    api_res 'theatres'
    api_res 't_halls'
    api_res 'u_apis'

    api_res 'perfs'

    api_res 't_perfs'
    api_res 'posters'
    api_res 'posts'


    #
    # Web-API routes
    #  Used by: Mobile app
    #
    #

    scope '/u_webs' do
        post 'register', to: 'u_webs#register'
        post 'update', to: 'u_webs#update'
    end

    scope module: 't_web' do
        post 'comments/new', to: 'comments#new'
    end


    root 'utils#root'
end
