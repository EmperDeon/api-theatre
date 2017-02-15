json.response @models do |m|
    json.(m, :id, :name, :author, :p_type_id, :approved)

    json.timestamps(m, :created_at, :updated_at, :deleted_at)
end
