json.response do
    json.(@model, :id, :desc, :desc_s)

    json.perf(@model.perf, :name, :author)
    json.type(@model.perf.p_type, :id, :name)

    json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end
