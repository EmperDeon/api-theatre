json.response do
    json.(@model, :date)

    json.perf(@model.t_perf.perf, :id, :name, :author, :t_hall)

    json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end
