json.response do
    json.(@model, :id, :name, :desc, :img)

    json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end
