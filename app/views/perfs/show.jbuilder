json.response do
    json.(@model, :id, :name, :author, :p_type_id)

    json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end
