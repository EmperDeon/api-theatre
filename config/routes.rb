Rails.application.routes.draw do
    # Generates 'REST' routes for specified controller
    #  Why not 'resources :name' ?
    #  Because i don't want to work with PATCH, PUT, etc. in Qt
    #
    #  name:: Prefix for route and controller name
    def res (name)
        scope '/' + name + '/' do
            get '/', to: name + '#index'
            get '/:id', to: name + '#show'
            post '/create', to: name + '#create'
            post '/update', to: name + '#update'
            post '/destroy', to: name + '#destroy'
            post '/restore', to: name + '#restore'
        end
    end


    scope '/auth_api' do
        get 'new', to: 'auth#api_auth'
        get 'check', to: 'auth#api_check'
        get 'perms', to: 'auth#api_perms'
    end

    scope '/auth_web' do
        get 'new', to: 'auth#web_auth'
        get 'check', to: 'auth#web_check'
    end

    scope '/utils' do
        get 'updates', to: 'utils#updates'
        get 'lists', to: 'utils#lists'
        # get 'change', to: 'utils#change'
    end


    res 'articles'
    res 'actors'
    res 'theatres'
    res 'users'

    res 't_perfs'
    res 'posters'
    res 'posts'
end
