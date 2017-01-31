Rails.application.routes.draw do
    # Generates 'REST' routes for specified controller
    #  Why not 'resources :name' ?
    #  Because i don't want to work with PATCH, PUT, etc. in Qt
    #
    #  name:: Prefix for route and controller name
    def res (name)
        scope '/' + name + '/' do
            # TODO: replace get with match get&post [for testing only]
            get '/', to: name + '#index'
            get '/:id', to: name + '#show'
            post '/create', to: name + '#create'
            post '/update', to: name + '#update'
            post '/destroy', to: name + '#destroy'
            post '/restore', to: name + '#restore'
        end
    end


    scope '/auth_api' do
        post 'new', to: 'auth#api_auth'
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
        # get 'change', to: 'utils#change'
    end


    res 'articles'
    res 'actors'
    res 'theatres'
    res 'u_apis'

    res 't_perfs'
    res 'posters'
    res 'posts'

    root 'utils#test'
end
