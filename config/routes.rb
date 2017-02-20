Rails.application.routes.draw do
    # Generates 'CRUD' routes for specified controller
    #  Why not 'resources :name' ?
    #  Because i don't want to work with PATCH, PUT, etc. in Qt (Theatres Admin App)
    #
    # name:: Prefix for route and controller name
    def res (name)
        scope '/' + name + '/' do
            post '/create', as: '', to: name + '#create'
            post '/update', as: '', to: name + '#update'
            post '/destroy', as: '', to: name + '#destroy'
            post '/restore', as: '', to: name + '#restore'
            match '/', as: '', to: name + '#index', via: [:get, :post]
            match '/:id', as: '', to: name + '#show', via: [:get, :post]
        end
    end


    scope '/auth_api' do
        match 'new', to: 'auth#api_auth', via: [:get, :post]
        post 'check', to: 'auth#api_check'
        post 'perms', to: 'auth#api_perms'
    end

    scope '/auth_web' do
        post 'new', to: 'auth#web_auth'
        post 'check', to: 'auth#web_check'
    end

    scope '/utils' do
        get 'updates', to: 'utils#updates'
        get 'lists', to: 'utils#lists'
        get 'hashes', to: 'utils#hashes'
        # get 'change', to: 'utils#change'

        post 'upload', to: 'utils#upload'
        get 'preview', to: 'utils#preview'

        get 'deleted', to: 'utils#get_deleted'
    end


    res 'articles'
    res 'actors'
    res 'theatres'
    res 't_halls'
    res 'u_apis'

    post 'perfs/approve', as: '', to: 'perfs#approve'
    res 'perfs'

    res 't_perfs'
    res 'posters'
    res 'posts'

    root 'utils#root'
end
