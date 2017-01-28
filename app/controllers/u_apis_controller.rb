class UApisController < ResourceController
    MODEL_CLASS = ::UApi

    def index
        @models = UApi.by_user(@current_user).where('login <> "admin"')
    end

    def create_action
        u = UApi.new(post_params)
        u.theatre_id = @current_user.theatre_id
        u.save!

        perms = JSON.parse(params[:perms] ||= '[]')
        u.u_perms << UPerm.find(perms.to_a)
    end

    def update_action
        u = @model
        u.theatre_id = @current_user.theatre_id
        u.update!(post_params)

        perms = JSON.parse(params[:perms] ||= '[]')
        u.u_perms.clear
        u.u_perms << UPerm.find(perms.to_a)
    end
end