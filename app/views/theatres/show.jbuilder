json.response do
    json.(@model, :name, :img, :desc, :address, :tel_num)

    json.t_halls @model.t_halls, :id, :name

    json.(@model, :created_at, :updated_at, :deleted_at)
end