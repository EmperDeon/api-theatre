json.response do
    json.(@model, :id, :name, :img, :desc, :address, :tel_num)

    json.t_halls @model.t_halls, :id, :name

    json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end