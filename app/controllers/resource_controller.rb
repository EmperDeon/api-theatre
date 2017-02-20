class ResourceController < ApplicationController
    # Controller for 'resources', like articles, theatres, etc.

    #
    # Before methods
    #
    before_action :check_api_token, :check_perm
    before_action :set_model, only: [:show, :update, :destroy, :restore]

    #
    # Model class
    # For faster controller creation
    # Used in set_model, get_params, and action index

    MODEL_CLASS = ::NilClass

    def model_class
        self.class::MODEL_CLASS
    end


    #
    # Actions
    #

    # These called from routes
    def index
        if params[:only_deleted] == 'true' # For 'deleted' tab in admin app
            @models = model_class.deleted

        else
            @models = model_class.order(id: :desc)

            if params[:with_deleted] == 'true'
                @models = @models.with_deleted
            end

            @models = @models.by_user(@current_user)
        end
    end

    def show
    end

    def create
        create_action
        res 'create_ok', :ok
    end

    def update
        update_action
        res 'update_ok', :ok
    end

    def destroy
        destroy_action
        res 'destroy_ok', :ok
    end

    def restore
        restore_action
        res 'restore_ok', :ok
    end


    # Actual methods, overridden in child classes
    # Override if need extra calls

    def create_action
    end

    def update_action
        @model.update!(post_params)
    end

    def destroy_action
        @model.destroy
    end

    def restore_action
        @model.restore
    end


    protected
    # Get current model
    def set_model
        @model = model_class.with_deleted.find(params[:id])
    end

    # Allowed fields for mass-assignment in create and update
    def post_params
        params.permit(model_class::FILLABLE)
    end


    #
    # Permissions helper methods
    #

    # Check, are current user has permission to view/perform current action(path)
    def check_perm
        path = request.env['PATH_INFO']

        path[0] = '' # Delete first '/' character
        path = path.split(/\//) # Split path to resource and action

        if path.size > 1
            perm = '_' + path[1]
            path = path[0]

            if perm =~ /_\d+/ # If perm is num
                perm = ''

            elsif perm == '_restore' # Because if user can destroy, he should be able to restore
                perm = '_destroy'

            end

            perm = path + perm

        else
            perm = path[0]
        end

        # Check, is current user has needed permission
        # unless @current_user.has_perm? perm
        #     err 'no_access', 'Not enough permissions to perform action ' + perm, 405
        # end
    end
end